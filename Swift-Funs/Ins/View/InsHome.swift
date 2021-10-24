//
//  InsHome.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/10/24.
//

import SwiftUI

struct InsHome: View {
    
    @State private var selectedTab = "house.fill"
    
    //To update for Dark mode
    @Environment(\.colorScheme) var scheme
    
    @Binding var offset: CGFloat
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            InsFeed(offset: $offset)
//                .padding(.top, Global.edges?.top)
                .tag("house.fill")
            
            Text("Search")
                .tag("magnifyingglass")
            
            Text("Reels")
                .tag("airplayvideo")
            
            Text("Liked")
                .tag("suit.heart.fill")
            
            Text("Account")
                .tag("person.circle")
            
        }
        .overlay(
            //custom tab bar
            VStack(spacing: 12) {
                Divider()
                    .padding(.horizontal, -15)
                
                HStack(spacing:0) {
                    TabBarButton(image: "house.fill", selectedTab: $selectedTab)
                        .frame(minWidth: 0, maxWidth: .infinity)
                    
                    TabBarButton(image: "magnifyingglass", selectedTab: $selectedTab)
                        .frame(minWidth: 0, maxWidth: .infinity)
                    
                    TabBarButton(image: "airplayvideo", selectedTab: $selectedTab)
                        .frame(minWidth: 0, maxWidth: .infinity)
                    
                    TabBarButton(image: "suit.heart.fill", selectedTab: $selectedTab)
                        .frame(minWidth: 0, maxWidth: .infinity)
                    
                    TabBarButton(image: "person.circle", selectedTab: $selectedTab)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
            }
                .padding(.horizontal)
                .padding(.bottom, Global.edges?.bottom ?? 15)
                .background(scheme == .dark ? Color.black : Color.white)
            
            
            , alignment: .bottom).ignoresSafeArea()
        
        
    }
}

//Tab Bar button
struct TabBarButton: View {
    
    var image: String
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {
            selectedTab = image
        }) {
            Image(systemName: image)
                .font(.title2)
                .foregroundColor(selectedTab == image ? .primary : .gray)
        }
    }
}

//struct InsHome_Previews: PreviewProvider {
//    static var previews: some View {
//        InsHome()
////            .preferredColorScheme(.dark)
//    }
//}
