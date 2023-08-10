//
//  HorizantalFixedGridView.swift
//  Qcoom
//
//  Created by Gafur on 4/12/22.
//

import SwiftUI

struct HorizantalFixedGridView<Content>: View where Content:View {
    let content: (Int) -> Content
    private let itemCount:Int
    private let rowCount:Int
    private let cellSpacing:CGFloat
   
   
    public init(
        itemCount:Int,
        rowCount:Int,
        cellSpacing:CGFloat = 10,
        @ViewBuilder content: @escaping (Int) -> Content){
        self.itemCount = itemCount
        self.rowCount = rowCount
        self.cellSpacing = cellSpacing
        self.content = content
       
    }
    
    var body : some View {
        let columnCount = (Double(itemCount) / Double(rowCount)).rounded(.up)
        VStack(alignment: .center,spacing:cellSpacing){
            ForEach(0..<Int(rowCount), id: \.self){ row in
                HStack(spacing:cellSpacing){
                    ForEach(0..<Int(columnCount), id: \.self){ column in
                        let index = row * Int(columnCount) + column
                        if index < itemCount {
                            self.content(index).frame(maxWidth:.infinity)
                        }else {
                            Spacer().frame(maxWidth:.infinity)
                        }

                    }
                    
                }
            }
        }.frame(maxWidth:.infinity)
    }
}

struct HorizantalFixedGridView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HorizantalFixedGridView(itemCount: 15, rowCount: 2, cellSpacing: 8){ index in
                CommerceCategoryCellView()
            }
        }
    }
}
