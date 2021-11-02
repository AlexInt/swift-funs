//
//  ToolbarPopoversHome.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/11/1.
//

import SwiftUI

struct ToolbarPopoversHome: View {
    //updating popover view
    @State private var graphicalDate = false
    @State private var showPicker = false
    
    @State private var show = false

    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showPicker) {
                    Text("Show Picker")
                }
                
                Toggle(isOn: $graphicalDate) {
                    Text("Show Graphical Date Picker")
                }
            }
            .navigationTitle("Popovers")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        withAnimation {
                            show.toggle()
                        }
                    }) {
                        Image(systemName: "slider.horizontal.below.square.fill.and.square")
                    }
                }
            }
        }
        .onTapGesture {
            if show {
                show.toggle()
            }
        }
        .toolBarPopover(show: $show, placement: .leading) {
            //Popover View
            if showPicker {
                Picker(selection: .constant("")) {
                    ForEach(1...10, id:\.self){index in
                        Text("Hello \(index)")
                            .tag(index)
                    }
                } label: {
                    
                }

            }
            else {
                if graphicalDate {
                    DatePicker("", selection: .constant(Date()))
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }
                else {
                    DatePicker("", selection: .constant(Date()))
                        .datePickerStyle(.compact)
                        .labelsHidden()
                }
            }
        }
        
    }
}


struct ToolbarPopoversHome_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarPopoversHome()
    }
}
