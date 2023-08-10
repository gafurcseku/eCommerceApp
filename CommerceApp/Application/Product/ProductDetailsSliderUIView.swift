//
//  ProductDetailsSliderUIView.swift
//  DhamakaShopping
//
//  Created by Invariant on 22/2/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailsSliderUIView: View {
    @Binding var index:Int
    var imageCount:Int  = 0
    var images:[String]

    
    var body: some View {
        PagingView(index: $index.animation(), maxIndex: imageCount) {
            ForEach(images , id: \.self) { items in
                WebImage(url: Helper.getImage(imageString: items))
                    .resizable()
                    .placeholder(Image("Image_placeholder").resizable().renderingMode(.original))
                    .indicator(.activity)
                    .scaledToFit()
            }
        }
        .frame(width:UIScreen.main.bounds.width,height: UIScreen.main.bounds.height * 0.40)
        .clipShape(RoundedRectangle(cornerRadius: 2))
 
    }
}

