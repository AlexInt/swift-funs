//
//  GlassMorphism.swift
//  Swift-Funs
//
//  Created by jimmy on 2022/2/4.
//

import SwiftUI

struct GlassMorphism: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color("glass_BG1"), Color("glass_BG2")],
                startPoint: .top,
                endPoint: .bottom)
                .ignoresSafeArea()
            
            //Glass Background....
            GeometryReader {proxy in
                let size = proxy.size
                
                //slightly darkening ...
                Color.black
                    .opacity(0.7)
                    .blur(radius: 200)
                    .ignoresSafeArea()
                
                Circle()
                    .fill(Color("glass_Purple"))
                    .padding(50)
                    .blur(radius: 120)
                //moving top ..
                    .offset(x: -size.width/1.8, y: -size.height/5)
                
                Circle()
                    .fill(Color("glass_LightBlue"))
                    .padding(50)
                    .blur(radius: 150)
                //moving top ..
                    .offset(x: size.width/1.8, y: -size.height/2)
                
                Circle()
                    .fill(Color("glass_LightBlue"))
                    .padding(50)
                    .blur(radius: 90)
                //moving top ..
                    .offset(x: size.width/1.8, y: size.height/2)
                
                //adding purple on both bottom ends...
                Circle()
                    .fill(Color("glass_Purple"))
                    .padding(100)
                    .blur(radius: 110)
                //moving top ..
                    .offset(x: size.width/1.8, y: size.height/2)
                
                Circle()
                    .fill(Color("glass_Purple"))
                    .padding(100)
                    .blur(radius: 110)
                //moving top ..
                    .offset(x: -size.width/1.8, y: size.height/2)
            }
            
            //content
            VStack {
                Spacer(minLength: 10)
                
                //GlassMorphism Card...
                ZStack {
                    //background balls
                    Circle()
                        .fill(Color("glass_Purple"))
                        .blur(radius: 20)
                        .frame(width: 100, height: 100)
                        .offset(x: 120, y: -80)
                    
                    Circle()
                        .fill(Color("glass_LightBlue"))
                        .blur(radius: 40)
                        .frame(width: 100, height: 100)
                        .offset(x: -120, y: 100)
                    
                    GlassMorphicCard()
                }
                
                Spacer(minLength: 10)
                
                Text("Know Everything\nabout the weather")
                    .font(.system(size:UIScreen.main.bounds.height < 750 ? 30 : 40, weight: .bold))
                
                Text(getAttributedString())
                    .fontWeight(.semibold)
                    .kerning(1.1)
                    .padding(.top, 10)
                
                Button {
                    
                } label: {
                    Text("Get started")
                        .font(.title3.bold())
                        .padding(.vertical,22)
                        .frame(maxWidth: .infinity)
                        .background(
                            .linearGradient(colors: [
                                Color("glass_Button11"),
                                Color("glass_Button12")
                            ], startPoint: .leading, endPoint: .trailing)
                            , in:RoundedRectangle(cornerRadius: 20)
                        )
                }
                .padding(.horizontal, 50)
                .padding(.vertical,20)
                
                Button {
                    
                } label: {
                    Text("Already have a account?")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                }


            }
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding()
        }
    }
    
    //going to use AttributedString from iOS 15
    func getAttributedString()->AttributedString {
        var attStr = AttributedString("Start now and learn more about \n local weather instantly")
        attStr.foregroundColor = .gray
        
        if let range = attStr.range(of: "local weather") {
            attStr[range].foregroundColor = .white
        }
        return attStr
        
    }
}

struct GlassMorphism_Previews: PreviewProvider {
    static var previews: some View {
        GlassMorphism()
    }
}

struct GlassMorphicCard: View {
    var body: some View {
        let width = UIScreen.main.bounds.width
        
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.white)
                .opacity(0.1)
                .background(
                    Color.white
                        .opacity(0.08)
                        .blur(radius: 10)
                )
            //strokes...
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(
                            .linearGradient(colors: [
                                Color("glass_Purple"),
                                Color("glass_Purple").opacity(0.5),
                                .clear,
                                .clear,
                                Color("glass_LightBlue"),
                            ], startPoint: .topLeading, endPoint: .bottomTrailing)
                            ,lineWidth: 2.5
                        )
                        .padding(2)
                )
            //shadows...
                .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: -5)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
            
            //Content
            VStack {
                Image(systemName: "sun.max")
                    .font(.system(size: 75, weight: .thin))
                
                Text("18")
                    .font(.system(size: 85, weight: .bold))
                    .padding(.top, 2)
                    .overlay(
                        Text("℃")
                            .font(.title2)
                            .foregroundColor(.white.opacity(0.7))
                            .offset(x: 30, y: 15)
                        
                        ,alignment: .topTrailing
                    )
                    .offset(x: -6)
                
                Text("Changning, Shanghai")
                    .font(.title3)
                    .foregroundColor(.white.opacity(0.4))
            }
            
        }
        .frame(width: width / 1.7, height: 270)
    }
}
