//
//  RefreshableHome.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/11/30.
//

import SwiftUI

struct RefreshableHome: View {
    @State var posts : [RefreshablePost] = []
    //    To show dynamic
    @State var columns: Int = 2
    //    Smooth Hero Effect...
    @Namespace var animation
    
    var body: some View {
        NavigationView {
            ScrollRefreshable(title: "", tintColor: .red, content: {
                StraggeredGrid(columns: columns,
                               list: posts,
                               content: { post in
                    //                Text(post.imageURL)
                    //                posts card view..
                    RefreshablePostCardView(post: post)
                        .matchedGeometryEffect(id: post.id, in: animation)
//                        .onAppear {
//                            print(post.imageURL)
//                        }
                })
                    .padding(.horizontal)
            }, onRefresh: {
                await Task.sleep(2_000_000_000)
            })
                .navigationTitle("Stragged Grid")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            columns += 1
                        } label: {
                            Image(systemName: "plus")
                        }
                        
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            columns = max(columns - 1 ,1)
                        } label: {
                            Image(systemName: "minus")
                        }
                    }
                }
                .animation(.easeInOut,value: columns)
        }
        .onAppear {
            for _ in 1...9 {
                let rand = Int.random(in: 1...9)
                let idx = rand > 8 ? rand - 8 : rand;
                let url = "posts\(idx)"
                
                posts.append(RefreshablePost(imageURL: url))
            }
        }
    }
}

struct RefreshableHome_Previews: PreviewProvider {
    static var previews: some View {
        RefreshableHome()
    }
}
// since we declare T is Identifiable...
// so we need to pass Identifiable conform collection/Array...
struct RefreshablePostCardView: View {
    var post : RefreshablePost
    var body: some View{
        Image(post.imageURL)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
    }
}
