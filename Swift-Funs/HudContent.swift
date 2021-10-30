//
//  HudContent.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/10/30.
//

import SwiftUI

struct HudContent: View {
    var body: some View {
        HudHome()
    }
}

struct HudContent_Previews: PreviewProvider {
    static var previews: some View {
        HudContent()
    }
}
struct HudHome:View {
    var body: some View {
        NavigationView {
            List {
                ForEach(1...30, id:\.self) { index in
                    NavigationLink("Navigate to page \(index)") {
                        Text("Detail page \(index)")
                            .navigationTitle("Detail")
                    }
                }
            }
            .navigationTitle("Home")
            .toolbar {
                Button("Show Hud") {
                    showHud(image: "airpodspro", color: .purple, title: "Connected") { status, msg in
                        if !status {
                            print(msg)
                        }
                    }
                }
            }
        }
//        .overlay(
//            HudView(image: "airpodspro", color: .primary, title: "Connected")
//        )
    }
}

extension View {
    func getRootController() -> UIViewController {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .init() }
        guard let root = scene.windows.last?.rootViewController else { return .init() }
        return root
    }
    
    func getScreenRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func showHud(image: String,
                 color: Color = .primary,
                 title: String,
                 completion: @escaping (Bool, String)->()) {
        
        //avoiding multiple huds
        if getRootController().view.subviews.contains(where: {$0.tag == 1009}) {
            completion(false, "Already presenting!")
            return
        }
        
        //converting swiftui view to uikit
        let hudViewController = UIHostingController(rootView: HudView(image: image, color: color, title: title))
        //content size
        let size = hudViewController.view.intrinsicContentSize
        
        hudViewController.view.frame.size = size
        hudViewController.view.frame.origin = CGPoint(x: (getScreenRect().width - size.width)/2, y: 50)
        hudViewController.view.backgroundColor = .clear
        
        hudViewController.view.tag = 1009;
        // adding to root
        getRootController().view.addSubview(hudViewController.view)
    }
}

struct HudView: View {
    var image: String
    var color: Color
    var title: String
    
    @Environment(\.colorScheme) var scheme
    
    @State private var showHud = false
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: image)
                .font(.title3)
                .foregroundColor(color)
            
            Text(title)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 10)
        .padding(.horizontal)
        .background(
            scheme == .dark ? Color.black : Color.white
        )
        .clipShape(Capsule())
        .shadow(color: .primary.opacity(0.1), radius: 5, x: 1, y: 5)
        .shadow(color: .primary.opacity(0.03), radius: 5, x: 0, y: -5)
        //moving to top
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .offset(y: showHud ? 0 : -200)
        .onAppear {
            withAnimation(.spring()) {
                showHud = true
            }
            
            //turn off hud
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    showHud = false
                }
                
                //waiting to finish the animation
                //then remove view with the help of tag
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    getRootController().view.subviews.forEach{
                        if $0.tag == 1009 {
                            $0.removeFromSuperview()
                        }
                    }
                }
            }
        }
        
        
    }
}
