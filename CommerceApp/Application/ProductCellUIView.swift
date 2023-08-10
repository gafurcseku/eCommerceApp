//
//  ProductCellUIView.swift
//  CommerceApp
//
//  Created by RootNext15 on 10/8/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductCellUIView: View {
    var imageString:String = DemoImageUrl
    var name:String = ""
    var selling:Double = 0.0
    var price:Double = 0.0
    var discountType:String = ""
    var stock:Int = 0
    var imageCount:Int = 2

    
    var body: some View {
        VStack(alignment: .center){
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                ImageUIView(image: Helper.getImage(imageString: imageString), columnCount: imageCount)
                if(discountType != ""){
                    UniNeueBoldTextView(text: discountType, fontSize: 12, colorName: "FFFFFF").padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6)).background( Color("000000")).cornerRadius(2).padding([.top],10)
                }
                
            }.frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .topLeading).layoutPriority(1)
            Spacer()
            VStack(alignment: .leading) {
                UniNeueRegularTextView(text: name, fontSize: 12, colorName: "000000").lineLimit(2)
                VStack(alignment:.leading) {
                    UniNeueBoldTextView(text: "\(BDT_SYMBOL_NO_Space)\(selling)", fontSize: 16, colorName: "000000").lineLimit(1).layoutPriority(1)
                    if price > 0.0 {
                        UniNeueBoldTextView(text: "\(BDT_SYMBOL_NO_Space)\(price)", fontSize: 10, colorName: "000000",strikethrough: true).lineLimit(1)
                    }
                }
                
                if (stock > 0){
                    UniNeueRegularTextView(text: "Stock Available", fontSize: 12, colorName: "000000")
                }else {
                    UniNeueRegularTextView(text: "Out of stock", fontSize: 12, colorName: "000000")
                }
                
                
            }.padding([.bottom,.leading,.trailing],4).frame(maxWidth: .infinity , alignment: .topLeading)
            
        }.frame(maxHeight: .infinity, alignment: .topLeading).background(Color.white).cornerRadius(6)
        
    }
}

struct ProductCellUIView_Previews: PreviewProvider {
    static var previews: some View {
        LazyGridView(itemCount: 15, columnCount: 2) { index in
            ProductCellUIView(imageString: "https://staging-jachai-service.s3-ap-southeast-1.amazonaws.com/static_image/2022-03-13T17:11:14.488_0330000079274.webp",name: "PEGASUS Fabio-125 Chopper (MAR21) PEGASUS Fabio-125 Chopper (MAR21) PEGASUS Fabio-125 Chopper (MAR21) PEGASUS Fabio-125 Chopper (MAR21)", selling: 3900.00,price:  3500.00,discountType: "Flat ৳200 OFF", stock: 1,imageCount: 2)
        }
        
      
    }
}
