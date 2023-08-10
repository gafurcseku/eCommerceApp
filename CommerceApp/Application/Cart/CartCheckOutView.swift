//
//  CartFooterView.swift
//  CommerceApp
//
//  Created by Md Abdul Gafur on 11/8/23.
//

import SwiftUI
import RealmSwift

struct CartCheckOutView: View {
    
    @ObservedResults(ProductRealm.self) var productRealm
   
    var body: some View {
        VStack{
            
                HStack {
                    Image(systemName: "cart").resizable().frame(width: 30, height: 30)
                        .foregroundColor(Color.white)
                    UrbanistSemiBoldTextView(text: "\(RealmManager.getTotal(productRealm: self.productRealm, promoDiscount: 0.0))", fontSize: 14, colorName: "FFFFFF")
                    UniNeueRegularTextView(text: "\(productRealm.count) items", fontSize: 12, colorName: "FFFFFF")
                    Spacer()
                    UrbanistSemiBoldTextView(text: "CHECKOUT", fontSize: 14, colorName: "FFFFFF")
                }
                .padding()
                .background(Color("3A494E"))
                .cornerRadius(6)
           
        }
        .padding(.bottom, 15)
        .padding([.leading,.trailing],15)
    }
}

struct CartCheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CartCheckOutView()
    }
}
