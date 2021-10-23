//
//  HoneyComb.swift
//  Swift-Funs
//
//  Created by jimmy on 2021/10/17.
//

import SwiftUI

struct HoneyComb: View {
    var body: some View {
        NavigationView {
            HoneyCombHomeView()
                .navigationTitle("Honey Comb")
        }
    }
}

struct HoneyComb_Previews: PreviewProvider {
    static var previews: some View {
        HoneyComb()
            .preferredColorScheme(.dark)
    }
}

struct HoneyCombHomeView: View {
    //Sample data for scrollview ...
    @State private var sampleData:[Date] = Array(repeating: Date(), count: 0)
    
    //since it is vertical scrollview...
    //so 2d array...
    @State private var rows:[[Date]] = []
    //padding = 30
    private let honeyCombWidth = UIScreen.main.bounds.width - 30
    
    
    private let horizontalSpacing: CGFloat = 10
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: -10) {
                ForEach(rows.indices, id:\.self) { index in
                    
                    HStack(spacing: horizontalSpacing) {
                        ForEach(rows[index],id:\.self) { value in
                            Hexagon()
                                .fill(Color.orange)
                                .frame(width: (honeyCombWidth - horizontalSpacing*2) / 3, height: 130)
                                .offset(x:getOffset(index: index))
                        }
                    }
                }
            }
            .padding()
            .frame(width: honeyCombWidth)
        }
        //menu Button ...
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button {
                        withAnimation(.spring()){
                            rows.removeAll()
                            sampleData.append(Date())
                            generateHoneyComb()
                        }
                    } label: {
                        Text("Add new Item")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title)
                        .foregroundColor(.orange)
                }
            }
        })
        .onAppear {
            generateHoneyComb()
        }
        
    }
    
    /*
     basic logic:
     if the row contains only one
     Column( View)
     then moving the view left
     side with
     offset y = width of hexagon /2
     
     if previous row and current row
     contains same amount of columns
     then also repeating the same process
     of moving view left
     
     By doing this we can achieve perfect
     honey Comb Structure
     */
    //setting extra honey comb views by calculating offset
    
    func getOffset(index: Int) -> CGFloat {
        let current = rows[index].count
        let singleItemWidth = ((honeyCombWidth - horizontalSpacing * 2) / 3)
        //moving half the width
        let offset = singleItemWidth / 2
        if index != 0 {
            let previous = rows[index - 1].count
            if current == 1 {
                if previous == 3 {
                    return -offset
                }
            }
            if current == previous {
                return -offset
            }
        }
        return 0
    }
    /*
     How we generating HoneyComb Rows For
     ScrollView?
     
     Row 1 Contains 2 Columns
     
     Row 2 Contains 3 Columns
     
     Row 3 Contains 2 Columns
     ...continues the same
     pattern and Generates
     [Rows].
     */
    //generating HoneyComb Rows ...
    func generateHoneyComb() {
        var count = 0
        var generated: [Date] = []
        for i in sampleData {
            generated.append(i)
            
            //checking and creating rows ..
            if generated.count == 2 {
                if let last = rows.last {
                    if last.count == 3 {
                        rows.append(generated)
                        generated.removeAll()
                    }
                }
                //for first time no data
                if rows.isEmpty {
                    rows.append(generated)
                    generated.removeAll()
                }
            }
            
            if generated.count == 3 {
                if let last = rows.last {
                    if last.count == 2 {
                        rows.append(generated)
                        generated.removeAll()
                    }
                }
            }
            
            count += 1
            //for exhaust data or single data ...
            if count == sampleData.count && !generated.isEmpty {
                rows.append(generated)
            }
        }
    }
    
}

/*
        pt6
 
 pt1               pt5
 
 
 pt2               pt4
 
        pt3
 */
//Hexagon shape
struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let pt1 = CGPoint(x: 0, y: 20)
            let pt2 = CGPoint(x: 0, y: rect.height - 20)
            let pt3 = CGPoint(x: rect.width/2, y: rect.height)
            let pt4 = CGPoint(x: rect.width, y: rect.height - 20)
            let pt5 = CGPoint(x: rect.width, y: 20)
            let pt6 = CGPoint(x: rect.width/2, y: 0)
            
            path.move(to: pt6)
            path.addArc(tangent1End: pt1, tangent2End: pt2, radius: 15)
            path.addArc(tangent1End: pt2, tangent2End: pt3, radius: 15)
            path.addArc(tangent1End: pt3, tangent2End: pt4, radius: 15)
            path.addArc(tangent1End: pt4, tangent2End: pt5, radius: 15)
            path.addArc(tangent1End: pt5, tangent2End: pt6, radius: 15)
            path.addArc(tangent1End: pt6, tangent2End: pt1, radius: 15)
        }
    }
}
