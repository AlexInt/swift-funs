//
//  ScrollRefreshable.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/11/30.
//

import SwiftUI

struct ScrollRefreshable<Content: View>: View {
    var content: Content
    var onRefresh: () async ->Void
    
    init(title: String,
         tintColor: Color,
         @ViewBuilder content: @escaping ()->Content,
         onRefresh: @escaping () async ->Void) {
        self.content = content()
        self.onRefresh = onRefresh
        
        UIRefreshControl.appearance().attributedTitle = NSAttributedString(string: title)
        UIRefreshControl.appearance().tintColor = UIColor(tintColor)
    }
    var body: some View {
        List {
            content
                .listRowSeparatorTint(.clear)
                .listRowBackground(Color.clear)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .listStyle(.plain)
        .refreshable {
            await onRefresh()
        }
    }
}

struct ScrollRefreshable_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableHome()
    }
}
