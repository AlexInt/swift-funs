//
//  SplashsAnimationView.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/11/3.
//

import SwiftUI

struct SplashsAnimationView: View {
    //Do actions When animation has been finished..
    @State private var endAnimation = false;

    var body: some View {
        ZStack {
            FakeHome()
            //Animating Home like its Moving from bottom
                .offset(y: endAnimation ? 0 : getRect().height)
            
            SplashScreen(endAnimation: $endAnimation)
        }
    }
}

struct FakeHome: View {
    
    var body: some View {
        NavigationView {
            List {
                ForEach(1...25, id:\.self) { index in
                    Text("row --- \(index)")
                }
            }
            .navigationTitle("Fake Home")
        }
    }
}

struct SplashsAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        SplashsAnimationView()
    }
}


struct SplashScreen: View {
    
    //animation properties
    @State private var startAnimation = false
    @State private var circleAnimation1 = false
    @State private var circleAnimation2 = false
    //End animation
    @Binding var endAnimation: Bool

    
    var body: some View {
        ZStack {
            Color("SplashColor")
            Group {
                //Custom shape with animation
                SplashShape()
                //triming
                    .trim(from: 0, to: startAnimation ? 1.0 : 0)
                //stroke to get outline
                    .stroke(Color.white, style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                
                //Two circles
                //left
                Circle()
                    .fill(.white)
                    .frame(width: 35, height: 35)
                    .scaleEffect(circleAnimation1 ? 1 : 0)
                    .offset(x: -80, y: 22)
                //right
                Circle()
                    .fill(.white)
                    .frame(width: 35, height: 35)
                    .scaleEffect(circleAnimation2 ? 1 : 0)
                    .offset(x: 80, y: -22)
            }
            //default frame
            .frame(width: 220, height: 130)
            .scaleEffect(endAnimation ? 0.15 : 0.9)
            .rotationEffect(.init(degrees: endAnimation ? 85 : 0))
            
            //bottom ta line
            VStack {
                Text("Powered by")
                    .font(.callout)
                    .fontWeight(.semibold)
                
                Text("TrippleRect")
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            .frame(maxHeight:.infinity, alignment: .bottom)
            .foregroundColor(.white.opacity(0.8))
            .padding(.bottom, getSafeArea().bottom == 0 ? 15 : getSafeArea().bottom)
            .opacity(startAnimation ? 1 : 0)
            .opacity(endAnimation ? 0 : 1)
        }
        //Moving View up
        .offset(y: endAnimation ? -(getRect().height * 1.5) : 0)
        .ignoresSafeArea()
        .onAppear {
            //Delay start
            //first circle
            withAnimation(.spring().delay(0.15)) {
                circleAnimation1.toggle()
            }
            //next shape
            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05).delay(0.3)) {
                startAnimation.toggle()
            }
            //Final scnd Circle
            withAnimation(.spring().delay(0.7)) {
                circleAnimation2.toggle()
            }
            //
            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 1.05, blendDuration: 1.05).delay(1.2)) {
                endAnimation.toggle()
            }
        }
    }
}

extension View {
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }
    func getSafeArea() -> UIEdgeInsets {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        guard let safeArea = scene.windows.first?.safeAreaInsets else {
            return .zero
        }
        return safeArea
    }
}

struct SplashShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path {path in
            let mid = rect.width / 2
            let height = rect.height
            
            //80 = 40: Arc Radius ...
            path.move(to: CGPoint(x: mid - 80, y: height))
            
            path.addArc(center: CGPoint(x: mid - 40, y: height), radius: 40, startAngle: .init(degrees: 180), endAngle: .zero, clockwise: true)
            
            //straight line ...
            path.move(to: CGPoint(x: mid, y: height))
            path.addLine(to: CGPoint(x: mid, y: 0))
            
            //another arc
            path.addArc(center: CGPoint(x: mid + 40, y: 0), radius: 40, startAngle: .init(degrees: -180), endAngle: .zero, clockwise: false)
            
        }
    }
}
