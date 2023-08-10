//
//  CartProductView.swift
//  CommerceApp
//
//  Created by Md Abdul Gafur on 11/8/23.
//

import SwiftUI
import SDWebImageSwiftUI
import RealmSwift

struct CartProductView: View {
    @ObservedResults(ProductRealm.self) var productRealm
    @State var addons:String = ""
    
    var body: some View {
        VStack(alignment: .leading){
         //   UniNeueBoldTextView(text: "ITEMS", fontSize: 14, colorName:"BDBDBD")
            VStack(spacing:20){
                ForEach(0..<productRealm.count , id:\.self) { index in
                    let product = productRealm[index]
                    var itemCount = product.quantity
                    HStack(spacing:3){
                        WebImage(url: Helper.getImage(imageString: product.getProductImage))
                            .resizable()
                            .placeholder(Image("Image_placeholder").resizable().renderingMode(.original))
                            .frame(width:40 , height: 40)
                            .scaledToFit()
                            .clipped()
                        VStack(alignment:.leading){
                            VStack(alignment:.leading){
                                UrbanistSemiBoldTextView(text: product.getName, fontSize: 14, colorName: "000000")
                              
                            }
                            
                            HStack {
                                UrbanistRegularTextView(text: "\(product.getMrp) X \(product.quantity)", fontSize: 14, colorName: "000000")
                                
                                HStack {
                                    Button(
                                        action: {
                                            if(itemCount > 0){
                                                itemCount -= 1
                                                if(itemCount == 0){
                                                    RealmManager.RemoveProductById(objectId:product.objectId)
                                                }else{
                                                    RealmManager.UpdateProduct(productId: product.id, variationId: product.getVariationId, updateValue: itemCount)
                                                }
                                            }
                                            
                                        },
                                        label: {
                                            Image(systemName: "minus")
                                                .foregroundColor(Color("FFFFFF"))
                                                .frame(width: 6, height: 6, alignment: .center)
                                                .padding(12)
                                                .background(Circle()
                                                    .fill(Color("00A88A")))
                                        }
                                    )
                                    
                                    UrbanistRegularTextView(text: "\(product.quantity)", fontSize: 15, colorName: "191B32")
                                        .padding([.leading,.trailing],5)
                                    
                                    Button(
                                        action: {
                                            if(itemCount < product.getMaximumCartLimit){
                                                itemCount += 1
                                                RealmManager.UpdateProduct(productId: product.id, variationId: product.getVariationId, updateValue: itemCount)
                                            }
                                        },
                                        label: {
                                            Image(systemName: "plus")
                                                .foregroundColor(Color("FFFFFF"))
                                                .frame(width: 6, height: 6, alignment: .center)
                                                .padding(12)
                                                .background(Circle()
                                                    .fill(Color("00A88A")))
                                        }
                                    )
                                }
                                .padding(.leading,7)
                            }
                        }
                        .padding(.leading, 10)
                                               
                        Spacer()
                    
                        UrbanistSemiBoldTextView(text: "\((product.getMrp) * Double( product.quantity))", fontSize: 14, colorName: "000000")
                        
                    }
                }
            }
            
        }
        .padding([.leading,.trailing],15)
        .padding([.top,.bottom],15)
        .background(Color.white)
        .padding(.top,2)
    }
    
}

struct CartProductView_Previews: PreviewProvider {
    static var previews: some View {
        CartProductView()
    }
}
