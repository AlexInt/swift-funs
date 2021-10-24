//
//  InsFeed.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/10/24.
//

import SwiftUI

struct InsFeed: View {
    
    @Binding var offset: CGFloat

    
    var body: some View {
        
        VStack(spacing: 15) {
            
            HStack(spacing: 15) {
                Button(action: {
                    
                }) {
                    Image(systemName: "plus.app")
                        .font(.title)
                        .foregroundColor(.primary)
                }
                
                Spacer()
                
                Button(action: {
                    offset = Global.rect.width * 2
                }) {
                    Image(systemName: "paperplane")
                        .font(.title)
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .overlay(
                Text("Instagram")
                    .font(.title2)
                    .bold()
            )
            
            ScrollView(.vertical, showsIndicators: false) {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack(spacing: 15) {
                        Button(action: {
                            
                        }, label: {
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 55, height: 55)
                                .clipShape(Circle())
                        })
                            .overlay(
                                Image(systemName: "plus.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.blue)
                                    .background(Color.white.clipShape(Circle()))
                                    .offset(x: 8, y: 5)
                                ,alignment: .bottomTrailing
                            )
                    }
                    .padding()
                    
                    
                    
                }
                
                Divider()
                    .padding(.horizontal, -15)
                
                VStack(spacing: 0) {
                    //posts
                    ForEach(posts) {post in
                        //post view
                        PostCardView(post: post)
                    }
                }
                .padding(.bottom, 65)
                
            }
            
        }
        
    }
}

//struct InsFeed_Previews: PreviewProvider {
//    static var previews: some View {
//        InsHome()
////            .preferredColorScheme(.dark)
//    }
//}


struct PostCardView: View {
    var post: Post
    @State private var comment = ""
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Image(post.profile)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                
                Text(post.user)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.primary)
                }
            }
            
            Image(post.postImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Global.rect.width - 30, height: 300)
                .cornerRadius(15)
            
            HStack(spacing: 15) {
                Button(action: {
                    
                }) {
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 25))
                }
                
                Button(action: {
                    
                }) {
                    Image(systemName: "paperplane")
                        .font(.system(size: 25))
                }
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    Image(systemName: "bookmark")
                        .font(.system(size: 25))
                }

                
            }
            .foregroundColor(.primary)
            
            (
                //binding two texts
                Text("\(post.user)  ")
                    .fontWeight(.bold)
                
                +
                
                Text(post.postTittle)
                
            )
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(6)
            
            HStack(spacing:15) {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 35, height: 35)
                    .clipShape(Circle())
                
                TextField("Add a comment ...", text: $comment)
            }
            
            Text(post.time)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.gray)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(6)
        }
        .padding()   
    }
}
