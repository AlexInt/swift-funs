//
//  MainView.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/10/24.
//

import SwiftUI

struct MainView: View {
    //handle left right scroll offset
    @State private var offset: CGFloat = Global.rect.width
    
    var body: some View {
        //scrollable tabs
        GeometryReader { reader in
            let frame = reader.frame(in: .global)
            //Since There ar three views
            ScrollableTabBar(tabs: ["","",""], rect: frame, offset: $offset) {
                
                PostView(offset: $offset)
                
                InsHome(offset: $offset)
                
                DirectView(offset: $offset)
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
