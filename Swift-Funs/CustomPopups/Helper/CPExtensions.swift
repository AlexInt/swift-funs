//
//  CPExtensions.swift
//  Swift-Funs
//
//  Created by jimmy on 2022/1/22.
//

import SwiftUI

//MARK: - custom view property extensions
extension View {
    
    /// building a custom modifier for custom popup navigation view
    func popupNavigationView<Content:View>(horizontalPadding: CGFloat = 40,
                                           show: Binding<Bool>,
                                           @ViewBuilder content: @escaping ()->Content) -> some View {
        return self
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay{
            if show.wrappedValue {
                //geometry reader for reading container frame
                GeometryReader{proxy in
                    Color.primary
                        .opacity(0.15)
                        .ignoresSafeArea()
                    let size = proxy.size
                    NavigationView {
                        content()
                    }
                    .frame(width: size.width - horizontalPadding, height: size.height/1.7, alignment: .center)
                    .cornerRadius(15)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
        }
    }
}
