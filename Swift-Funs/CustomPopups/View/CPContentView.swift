//
//  CPContentView.swift
//  Swift-Funs
//
//  Created by jimmy on 2022/1/22.
//

import SwiftUI

struct CPContentView: View {
    @State private var showPopup = false
    var body: some View {
        NavigationView {
            Button("Show Popup") {
                withAnimation {
                    showPopup.toggle()
                }
            }
            .navigationTitle("Custom Popup's")
        }
        .popupNavigationView(horizontalPadding: 40, show: $showPopup) {
            //your popup content which will also performs navigations
            List{
                ForEach(tasks) {task in
                    NavigationLink(task.taskTitle) {
                        Text(task.taskDescription)
                            .navigationTitle("Destination")
                    }
                }
            }
            .navigationTitle("popup navigation")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                    }

                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        withAnimation {
                            showPopup.toggle()
                        }
                    }

                }
            }
        }
    }
}

struct CPContentView_Previews: PreviewProvider {
    static var previews: some View {
        CPContentView()
    }
}
