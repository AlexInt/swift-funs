//
//  Neumorphism.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/11/6.
//

import SwiftUI

struct Neumorphism: View {
    var body: some View {
        ZStack {
            Color.gray.opacity(0.7)
            VStack(spacing: 15.0) {
                NeumorphismDark()
                Text("Neumorphism")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                NeumorphismLight()
            }
        }
    }
}

struct Neumorphism_Previews: PreviewProvider {
    static var previews: some View {
        Neumorphism()
    }
}

//MARK: - light

struct NeumorphismLight: View {
    var body: some View {
        ZStack {
            Color.OffWhite
            //            RoundedRectangle(cornerRadius: 25)
            //                .fill(Color.OffWhite)
            //                .frame(width: 300, height: 300)
            //                .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
            //                .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
            Button(action: {
                print("Button tapped")
            }, label: {
                Image(systemName: "heart.fill")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            })
            .buttonStyle(SimpleButtonStyle())
        }
        .edgesIgnoringSafeArea(.all)
    }
}


struct SimpleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                Group {
                    if configuration.isPressed {
                        Circle()
                            .fill(Color.OffWhite)
                            .overlay(
                                Circle()
                                    .stroke(Color.gray,lineWidth: 4)
                                    .blur(radius: 4)
                                    .offset(x: 2, y: 2)
                                    .mask(Circle().fill(LinearGradient(Color.black, Color.clear)))
                            )
                            .overlay(
                                Circle()
                                    .stroke(Color.white,lineWidth: 8)
                                    .blur(radius: 4)
                                    .offset(x: -2, y: -2) //value in reverse
                                    .mask(Circle().fill(LinearGradient(Color.clear, Color.black)))
                            )
                    } else {
                        Circle()
                            .fill(Color.OffWhite)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
                    }
                }
            )
    }
}

//MARK: DARK

struct NeumorphismDark: View {
    @State private var isToggled = false
    
    
    var body: some View {
        ZStack {
            LinearGradient(Color.darkStart,Color.darkEnd)
            HStack(spacing: 50.0) {
                VStack(spacing: 40.0) {
                    Button(action: {
                        print("Button tapped")
                    }, label: {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                    })
                    .buttonStyle(DarkButtonStyle())
                    
                    Toggle(isOn: $isToggled, label: {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    })
                    .toggleStyle(DarkToggleStyle())
                }
                
                VStack(spacing: 40.0) {
                    Button(action: {
                        print("Button tapped")
                    }, label: {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                    })
                    .buttonStyle(ColorfulButtonStyle())
                    
                    Toggle(isOn: $isToggled, label: {
                        Image(systemName: "heart.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    })
                    .toggleStyle(ColorfulToggleStyle())
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct DarkBackground<S: Shape>: View {
    var isHighlighted:Bool
    var shape: S
    
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.darkEnd,Color.darkStart))
                    .overlay(
                        Circle()
                            .stroke(Color.darkStart,lineWidth: 4)
                            .blur(radius: 4)
                            .offset(x: 2, y: 2)
                            .mask(Circle().fill(LinearGradient(Color.darkEnd, Color.clear)))
                    )
                    .overlay(
                        Circle()
                            .stroke(Color.darkStart,lineWidth: 8)
                            .blur(radius: 4)
                            .offset(x: -2, y: -2) //value in reverse
                            .mask(Circle().fill(LinearGradient(Color.clear, Color.darkEnd)))
                    )
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart,Color.darkEnd))
                    .shadow(color: .darkStart, radius: 10, x: -5, y: -5)
                    .shadow(color: .darkEnd, radius: 10, x: 10, y: 10)
            }
        }
    }
}

struct ColorfulBackground<S: Shape>: View {
    var isHighlighted:Bool
    var shape: S
    
    var body: some View {
        ZStack {
            if isHighlighted {
                shape
                    .fill(LinearGradient(Color.lightEnd,Color.lightStart))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart,Color.lightEnd),lineWidth: 4))
                    .shadow(color: .darkStart, radius: 10, x: 5, y: 5)
                    .shadow(color: .darkEnd, radius: 10, x: -5, y: -5)
            } else {
                shape
                    .fill(LinearGradient(Color.darkStart,Color.darkEnd))
                    .overlay(shape.stroke(LinearGradient(Color.lightStart,Color.lightEnd),lineWidth: 4))
                    .shadow(color: .darkStart, radius: 10, x: -10, y: -10)
                    .shadow(color: .darkEnd, radius: 10, x: 10, y: 10)
            }
        }
    }
}

struct DarkToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            configuration.label
                .padding(30)
                .contentShape(Circle())
        })
        .background(
            DarkBackground(isHighlighted: configuration.isOn, shape: Circle())
        )
    }
}

struct DarkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                DarkBackground(isHighlighted: configuration.isPressed, shape: Circle())
            )
    }
}

struct ColorfulToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            configuration.label
                .padding(30)
                .contentShape(Circle())
        })
        .background(
            ColorfulBackground(isHighlighted: configuration.isOn, shape: Circle())
        )
    }
}

struct ColorfulButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(30)
            .contentShape(Circle())
            .background(
                ColorfulBackground(isHighlighted: configuration.isPressed, shape: Circle())
            )
    }
}



extension Color {
    static let OffWhite = Color(red: 225/255, green: 225/255, blue: 235/255)
    
    static let darkStart = Color(red: 50/255, green: 60/255, blue: 65/255)
    static let darkEnd = Color(red: 25/255, green: 25/255, blue: 30/255)
    
    static let lightStart = Color(red: 60/255, green: 160/255, blue: 240/255)
    static let lightEnd = Color(red: 30/255, green: 80/255, blue: 120/255)
}

extension LinearGradient {
    init(_ colors: Color...) {
        self.init(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
