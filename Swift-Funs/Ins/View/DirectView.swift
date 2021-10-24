//
//  DirectView.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/10/24.
//

import SwiftUI

struct DirectView: View {
    
    @Binding var offset: CGFloat
    @State private var search = ""
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Button {
                    offset = Global.rect.width
                } label: {
                    HStack{
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .black))
                        
                        Text("Direct")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "video")
                        .font(.title)
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.title)
                }


            }
            .foregroundColor(.primary)
            .padding()
            
            ScrollView {
                VStack(spacing: 15) {
                    HStack(spacing: 15) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search", text: $search)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(Color.primary.opacity(0.06))
                    .cornerRadius(12)
                    
                    ForEach(posts) {post in
                        HStack(spacing: 15) {
                            Image(post.profile)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 55, height: 55)
                                .clipShape(Circle())
                            
                            Text(post.user)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "camera")
                                    .font(.title)
                            }
                            .foregroundColor(.gray)

                        }
                        .padding(.top, 8)
                    }
                }
                .padding()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.top, Global.edges?.top ?? 15)
        .padding(.bottom, Global.edges?.bottom ?? 15)
    }
}

struct DirectView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
