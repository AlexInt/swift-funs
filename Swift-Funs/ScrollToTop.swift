//
//  ScrollToTop.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/11/14.
//

import SwiftUI

struct ScrollToTop: View {
    var body: some View {
        NavigationView {
            STTHome()
                .navigationTitle("Medium")
        }
    }
}

struct ScrollToTop_Previews: PreviewProvider {
    static var previews: some View {
        ScrollToTop()
    }
}

struct STTHome: View {
    @State private var scrollViewOffset: CGFloat = 0
    /*
     Getting start offset and eliminating from current offset so that
     we will get exact offset
     */
    @State var startOffset: CGFloat = 0
    
    var body: some View {
        //scroll to top function with the help of scrollview reader
        ScrollViewReader{proxyReader in
            
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(spacing: 25) {
                    ForEach(1...30, id:\.self) { index in
                        HStack(spacing: 15) {
                            Circle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(width: 60, height: 60)
                            VStack(alignment: .leading, spacing: 8, content: {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(height:22)
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.gray.opacity(0.5))
                                    .frame(height:22)
                                    .padding(.trailing, 100)
                            })
                            
                        }
                    }
                }
                .padding()
                //setting ID
                //so that it can scroll to that position
                .id("SCROLL_TO_TOP")
                //getting scrollview offset
                .overlay(
                    //using Geometry Reader to get Scrollview Offset
                    GeometryReader{proxy -> Color in
                        DispatchQueue.main.async {
                            if startOffset == 0 {
                                self.startOffset = proxy.frame(in: .global).minY
                            }
                            let offset = proxy.frame(in: .global).minY
                            self.scrollViewOffset = offset - startOffset
                            print(self.scrollViewOffset)
                        }
                        
                        return Color.clear
                    }
                        .frame(width: 0, height: 0)
                    , alignment: .top)
            })
            //if offset goes less than 450 then showing floating
            //action button at bottom...
                .overlay(
                    Button(action: {
                        withAnimation(.spring()) {
                            proxyReader.scrollTo("SCROLL_TO_TOP", anchor: .top)
                        }
                    }, label: {
                        Image(systemName: "arrow.up")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("box1"))
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.09), radius: 5, x: 5, y: 5)
                        
                    })
                        .padding(.trailing)
                        .padding(.bottom, getSafeArea().bottom == 0 ? 12 : 0)
                        .opacity(-scrollViewOffset > 450 ? 1 : 0)
                        .animation(.easeInOut)
                    
                    //fixing at bottom left
                    , alignment: .bottomTrailing
                )
        }
    }
}

