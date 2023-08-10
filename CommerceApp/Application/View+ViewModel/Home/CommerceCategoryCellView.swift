//
//  CategoryCellView.swift
//  Jachai
//
//  Created by Gafur on 10/10/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct CommerceCategoryCellView: View {
    var cellWidth:CGFloat = 76.0
    var cellHeight:CGFloat = 84.0
    var  ration:CGFloat = 0.55
    var imageString:String = DemoImageUrl
    var name:String = "Baby Accessorices"
    var body: some View {
        VStack(alignment: .center){
            VStack {
                WebImage(url: Helper.getImage(imageString: imageString))
                    .resizable()
                    .placeholder(Image("Image_placeholder").resizable().renderingMode(.original))
                    .frame(width: 35 , height:35)
                    .scaledToFit()
                   
            }
            .padding(10)
            .frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .center)
            
            VStack {
                Spacer()
                UrbanistMediumTextView  (text: name, fontSize: 12, colorName: "191B32")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,10)
                    
                Spacer()
            }
        }
        .background(Color.white)
        .frame(maxWidth: cellWidth,  maxHeight: cellHeight, alignment: .center)
        .cornerRadius(6)
        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("E6E6E6"), lineWidth: 1))
       
    }
}

struct CommerceCategoryCellView_Previews: PreviewProvider {
    static var previews: some View {
        CommerceCategoryCellView()
    }
}
