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
    static var edges: UIEdgeInsets? {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return nil
        }
        guard let safeArea = scene.windows.first?.safeAreaInsets else {
            return nil
        }
        return safeArea
    }
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

