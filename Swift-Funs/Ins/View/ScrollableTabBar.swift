//
//  ScrollableTabBar.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/10/24.
//

import SwiftUI

struct ScrollableTabBar<Content: View>: UIViewRepresentable {
    //to store our swiftui view
    var content: Content
    
    //getting rect to calculate width and height of scrollview
    var rect: CGRect
    
    //contentOffset
    @Binding var offset: CGFloat

    //tabs
    var tabs: [Any]
    //scrollview
    //For paging aka scrollable tabs
    let scrollView = UIScrollView()
    init(tabs: [Any], rect: CGRect, offset: Binding<CGFloat>, @ViewBuilder content: ()-> Content) {
        self.content = content()
        self._offset = offset
        self.rect = rect
        self.tabs = tabs
    }
    
    // work with UIScrollViewDelegate
    func makeCoordinator() -> Coordinator {
        return ScrollableTabBar.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        setUpScrollView()
        //setting content size
        scrollView.contentSize = CGSize(width: Global.rect.width * CGFloat(tabs.count),
                                        height: Global.rect.height)
        
        scrollView.contentOffset.x = offset
        
        scrollView.addSubview(extractView())
        scrollView.delegate = context.coordinator
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        //updating view
        if uiView.contentOffset.x != offset {
            //Animating
            //The animation Glitch is because its updating on two times
            
            //Simple
            //Removing Delegate While Animating
            uiView.delegate = nil
            
            UIView.animate(withDuration: 0.4) {
                uiView.contentOffset.x = offset
            } completion: { status in
                if status {
                    uiView.delegate = context.coordinator
                }
            }

        }
    }
    
    func setUpScrollView() {
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    //Extracting SwiftUI View
    func extractView() -> UIView {
        //since it depends upon tab size
        // so we getting tabs also
        
        //For ease of use
        let controller = UIHostingController(rootView: HStack(spacing:0){content}.ignoresSafeArea())
        controller.view.frame = CGRect(x: 0, y: 0, width: Global.rect.width * CGFloat(tabs.count), height: Global.rect.height)
        return controller.view!
    }
    
    //delegate function for get offset
    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: ScrollableTabBar
        
        init(parent: ScrollableTabBar) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
    }
}
