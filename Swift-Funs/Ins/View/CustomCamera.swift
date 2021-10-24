//
//  CustomCamera.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/10/24.
//

import SwiftUI
import AVFoundation

//struct CustomCamera: View {
//    var body: some View {
//        CameraView()
//    }
//}
//
//struct CustomCamera_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomCamera()
//    }
//}

struct CameraView: View {
    @ObservedObject var camera = CameraModel()
    @Binding var offset: CGFloat
    
    var body: some View {
        ZStack {
            
            //Going to be camera preview
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)
            
            VStack {
                
                Spacer()
                
                HStack {
                    //if taken showing save and again take button
                    
                    if camera.isTaken {
                        
                        Button(action: camera.reTake) {
                            Image(systemName: "arrow.triangle.2.circlepath.camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                    }
                    else {
                        Button(action: camera.takePic) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65, height: 65)
                                
                                Circle()
                                    .stroke(Color.white,lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        }
                    }
                    
                }
                .frame(height: 75)
                .padding(.bottom, Global.edges?.bottom ?? 15)
            }
            
            
        }
        .onAppear {
            camera.check()
        }
        .alert(isPresented: $camera.alert) {
            Alert(title: Text("Please Enable Camera Access"))
        }
        .onChange(of: offset) { newValue in
            if newValue == 0 && !camera.session.isRunning {
                camera.session.startRunning()
            }
            else {
                if camera.session.isRunning {
                    camera.session.stopRunning()
                }
            }
        }
        
    }
}


class CameraModel:  NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isTaken = false
    
    @Published var session = AVCaptureSession()
    
    @Published var alert = false
    
    //since were going to read pic data
    @Published var output = AVCapturePhotoOutput()
    
    //preview
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    //pic data
    
    @Published var isSaved = false
    
    @Published var picData = Data(count: 0)
    
    func check() {
        //first checking camera got permission
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
        case .notDetermined:
            //request for permission
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status {
                    self.setUp()
                }
            }
        case .denied:
            self.alert.toggle()
        default:
            break
        }
    }
    
    /// setting up session
    func setUp() {
        do {
            //setting configs
            self.session.beginConfiguration()
            
            //change for your own, for me iPhone 12 is .builtInDualWideCamera, command + left click to checkout
            guard let device = AVCaptureDevice.default(.builtInDualWideCamera, for: .video, position: .back) else { return }
            let input = try AVCaptureDeviceInput(device: device)
            
            //checking and adding to session
            if self.session.canAddInput(input) {
                self.session.addInput(input)
            }
            
            //same for output
            if self.session.canAddOutput(self.output) {
                self.session.addOutput(self.output)
            }
            self.session.commitConfiguration()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func takePic() {
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.stopRunning()
            
            DispatchQueue.main.async {
                UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 0.5)
                withAnimation {
                    self.isTaken.toggle()
                }
            }
        }
    }
    
    func reTake() {
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            
            DispatchQueue.main.async {
                UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: 0.5)
                withAnimation {
                    self.isTaken.toggle()
                    
                    //clearing
                    self.isSaved = false
                }
            }
        }
    }
    
    //Use it when you Customizing or saving pic..
//    func savePic() {
//        guard let image = UIImage(data: self.picData) else {
//            return
//        }
//
//        //saving image
//        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//        self.isSaved = true
//        print("saved Successfully...")
//    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard error == nil else {
            return
        }
        
        print("pic taken")
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        
        self.picData = imageData
    }
}

struct CameraPreview: UIViewRepresentable {
    
    @ObservedObject var camera: CameraModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        
        //choose for your own
        camera.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(camera.preview)
        
        //Only turning on camera when offset sets to 0
        //to avoid RAM usage
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
