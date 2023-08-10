//
//  LazyGridView.swift
//  DhamakaShopping
//
//  Created by Gafur on 10/4/21.
//

import SwiftUI


struct LazyGridView<Content>: View where Content:View {
    let content: (Int) -> Content
    private let itemCount:Int
    private let columnCount:Int
    private let cellSpacing:CGFloat
    private var canLoadNext:(() -> Void)? = nil
   
    
    public init(
        itemCount:Int,
        columnCount:Int,
        cellSpacing:CGFloat = 10,
        @ViewBuilder content: @escaping (Int) -> Content,
        canLoadNext:(() -> Void)? = nil){
        self.itemCount = itemCount
        self.columnCount = columnCount
        self.cellSpacing = cellSpacing
        self.content = content
        self.canLoadNext = canLoadNext
    }
    
    var body : some View {
        let rowCount = (Double(itemCount) / Double(columnCount)).rounded(.up)
        LazyVStack(spacing:cellSpacing){
            ForEach(0..<Int(rowCount), id: \.self){ row in
                HStack(spacing:cellSpacing){
                    ForEach(0..<columnCount, id: \.self){ column in
                        let index = row * columnCount + column
                        if index < itemCount {
                            self.content(index).frame(maxWidth:.infinity)
                                .onAppear(perform: {
                                    if index == itemCount - 1 {
                                        if let loadNext = self.canLoadNext {
                                            loadNext()
                                        }
                                    }
                                })
                        }else {
                            Spacer().frame(maxWidth:.infinity)
                        }
                        
                    }
                    
                }
            }
        }.frame(maxWidth:.infinity)
    }
}

struct LazyGridView_Preview : PreviewProvider {
    static var previews: some View {
        VStack{
            
        }
    }
}
