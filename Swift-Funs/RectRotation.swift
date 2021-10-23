//
//  RectRotation.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/10/23.
//

import SwiftUI

struct RectRotation: View {
    var body: some View {
        Home()
    }
}

struct RectRotation_Previews: PreviewProvider {
    static var previews: some View {
        RectRotation()
    }
}

struct Home: View {
    
    //Animation properties...
    @State private var offsets:[CGSize] = Array(repeating: .zero, count: 3)
    
    //static offsets for one full complete rotation...
    var locations: [CGSize] = [
        
        //rotation1
        CGSize(width: 110, height: 0),
        CGSize(width: 0, height: -110),
        CGSize(width: -110, height: 0),
        
        //rotation2
        CGSize(width: 110, height: 110),
        CGSize(width: 110, height: -110),
        CGSize(width: -110, height: -110),
        
        //rotation3
        CGSize(width: 0, height: 110),
        CGSize(width: 110, height: 0),
        CGSize(width: 0, height: -110),
        
        //final resetting rotation...
        CGSize(width: 0, height: 0),
        CGSize(width: 0, height: 0),
        CGSize(width: 0, height: 0),
    ]
    
    //So after One complete rotation it will again fire animation
    // for that were going to use Timer
    // 0.3 * 12 + 0.4
    @State private var timer = Timer.publish(every: 4.0, on: .current, in: .common).autoconnect()
    
    @State private var delayTime:Double = 0
    
    var body: some View {
        ZStack {
            Color("bg")
                .ignoresSafeArea()
            
            //Loader View...
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    Rectangle()
                        .fill(Color("box1"))
                        .frame(width: 100, height: 100)
                        .offset(offsets[0])
                }
                //with spacing 100+100+10
                .frame(width: 210, alignment: .leading)
                
                HStack(spacing: 10) {
                    Rectangle()
                        .fill(Color("box2"))
                        .frame(width: 100, height: 100)
                        .offset(offsets[1])
                    
                    Rectangle()
                        .fill(Color("box3"))
                        .frame(width: 100, height: 100)
                        .offset(offsets[2])
                }
            }
        }
        .onAppear(perform: doAnimation)
        .onReceive(timer) { _ in
            //resetting timer
            
            //redo animations
            delayTime = 0
            doAnimation()
        }
    }
    
    func doAnimation() {
        //doing our animation here ..
        
        //since we have three offsets so we were
        //going to convert this array to subarrays of max three elements
        //you can directly declare as subarrays
        //Im doing like this its your choice
        
        var tempOffsets:[[CGSize]] = []
        
        var currentSet:[CGSize] = []
        
        for value in locations {
            currentSet.append(value)
            if currentSet.count == 3 {
                //append to main array..
                tempOffsets.append(currentSet)
                //clearing
                currentSet.removeAll()
            }
        }
        
        //checking if any incomplete array
        if !currentSet.isEmpty {
            tempOffsets.append(currentSet)
            currentSet.removeAll()
        }
        
//        print(tempOffsets)
        //Animation
        for offset in tempOffsets {
            for index in offset.indices {
                //each box shift will take 0.5 sec to finish
                //so delay will be 0.3 and its multiplies
                doAnimation(delay: .now() + delayTime, value: offset[index], index: index)
                delayTime += 0.3
            }
        }
        
    }
    
    func doAnimation(delay:DispatchTime, value:CGSize, index: Int) {
        DispatchQueue.main.asyncAfter(deadline: delay) {
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                self.offsets[index] = value
            }
        }
    }
}

//just cancel timer when new page open or closed

