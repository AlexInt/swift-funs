//
//  MarqueeText.swift
//  Swift-Funs
//
//  Created by jimmy on 2022/1/30.
//

import SwiftUI

struct MarqueeText: View {
    var body: some View {
        Marquee(text: "since it scrolls horizontal using scrollviewsince it scrolls horizontal using scrollview", font: .systemFont(ofSize: 20, weight: .medium))
            .padding(.horizontal, 15)
    }
}

struct MarqueeText_Previews: PreviewProvider {
    static var previews: some View {
        MarqueeText()
    }
}

struct Marquee: View {
    @State var text: String
    //MARK: - customization options
    var font: UIFont
    //Storing text size
    @State private var storedSize: CGSize = .zero
    //animation offset
    @State private var offset: CGFloat = 0
    var animationSpeed: Double = 0.02
    var delayTime: Double = 0.5
    @Environment(\.colorScheme) var scheme
    
    
    var body: some View {
        //since it scrolls horizontal using scrollview
        ScrollView(.horizontal, showsIndicators: false) {
            Text(text)
                .font(Font(uiFont: font))
                
                .offset(x:offset)
        }
        .overlay(content: {
            HStack {
                let color: Color = scheme == .dark ? .black : .white
                LinearGradient(colors: [color, color.opacity(0.7),color.opacity(0.5),color.opacity(0.3)], startPoint: .leading, endPoint: .trailing)
                    .frame(width: 20)
                
                Spacer()
                
                LinearGradient(colors: [color, color.opacity(0.7),color.opacity(0.5),color.opacity(0.3)].reversed(), startPoint: .leading, endPoint: .trailing)
                    .frame(width: 20)
                
            }
        })
        //Disabling manual scrolling
        .disabled(true)
        .onAppear {
            
            let baseText = text
            //continous text animation
            //adding spacing for continous text
            (1...15).forEach { _ in
                text.append(" ")
            }
            //stopping animation exactly before the next text
            storedSize = textSize()
            text.append(baseText)
            
            //Calculating Total secs based on Text Width
            //Our animation speed for each charater will be 0.02s
            let timing: Double = (animationSpeed * storedSize.width)
            
            //delay first animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: timing)) {
                    offset = -storedSize.width
                }
            }
        }
        //repeating marquee effect with the help of Timer
        //Optional: if you want some delay for next animation
        .onReceive(Timer.publish(every: (animationSpeed * storedSize.width + delayTime), on: .main, in: .default).autoconnect()) { _ in
            //resetting offset to 0
            //Thus its look its looping
            offset = 0
            withAnimation(.linear(duration: animationSpeed * storedSize.width)) {
                offset = -storedSize.width
            }
        }
    }
    
    //fetch text size for offset animation
    func textSize() -> CGSize {
        let attributes = [NSAttributedString.Key.font:font]
        let size = (text as NSString).size(withAttributes: attributes)
        return size
    }
}

public extension Font {
    init(uiFont: UIFont) {
        self = Font(uiFont as CTFont)
    }
}
