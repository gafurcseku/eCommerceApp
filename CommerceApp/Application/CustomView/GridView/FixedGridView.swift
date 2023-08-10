//
//  FixedGridView.swift
//  DhamakaShopping
//
//  Created by Gafur on 12/4/21.
//

import SwiftUI

struct FixedGridView<Content>: View where Content:View {
    let content: (Int) -> Content
    private let itemCount:Int
    private let columnCount:Int
    private let cellSpacing:CGFloat
   
   
    public init(
        itemCount:Int,
        columnCount:Int,
        cellSpacing:CGFloat = 10,
        @ViewBuilder content: @escaping (Int) -> Content){
        self.itemCount = itemCount
        self.columnCount = columnCount
        self.cellSpacing = cellSpacing
        self.content = content
       
    }
    
    var body : some View {
        let rowCount = (Double(itemCount) / Double(columnCount)).rounded(.up)
        VStack(alignment: .center,spacing:cellSpacing){
            ForEach(0..<Int(rowCount), id: \.self){ row in
                HStack(spacing:cellSpacing){
                    ForEach(0..<columnCount, id: \.self){ column in
                        let index = row * columnCount + column
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



