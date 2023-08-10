//
//  ImageUIView.swift
//  CommerceApp
//
//  Created by RootNext15 on 10/8/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageUIView: View {
    var image:URL?
    var columnCount:Int = 0

    var body: some View {
        GeometryReader{ proxi in
            WebImage(url: image)
                .resizable()
                .placeholder(Image("Image_placeholder").resizable().renderingMode(.original))
                .frame(width: proxi.size.width, height: proxi.size.width, alignment: .center)
                .clipped()
                .scaledToFit()
            
        }
        .frame(minHeight: self.columnCount == 0 ? nil: UIScreen.main.bounds.width/CGFloat(columnCount),maxHeight:.infinity, alignment: .center)
        
    }
}

struct ImageUIView_Previews: PreviewProvider {
    static var previews: some View {
        ImageUIView(image: Helper.getImage(imageString: DemoImageUrl))
    }
}
