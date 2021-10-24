//
//  PostView.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/10/24.
//

import SwiftUI

struct PostView: View {
    @Binding var offset: CGFloat
    
    var body: some View {
        ZStack {
            Color.black
            
            CameraView(offset: $offset)
            
            VStack {
                HStack {
                    Button {
                        
                    } label: {
                        Image(systemName: "gear")
                            .font(.title)
                    }
                    
                    Spacer()
                    
                    Button {
                        offset = Global.rect.width
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title)
                    }
                }
                .foregroundColor(.white)
                .padding()
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "photo")
                        .font(.title)
                }
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .padding(.top, Global.edges?.top ?? 15)
            .padding(.bottom, Global.edges?.bottom)
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
