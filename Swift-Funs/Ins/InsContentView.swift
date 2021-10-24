//
//  InsContentView.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/10/24.
//

import SwiftUI

//Global Usage Values...
enum Global {
    static var rect = UIScreen.main.bounds
    static var edges = UIApplication.shared.windows.first?.safeAreaInsets
}


struct InsContentView: View {
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        MainView()
    }
}

struct InsContentView_Previews: PreviewProvider {
    static var previews: some View {
        InsContentView()
    }
}

