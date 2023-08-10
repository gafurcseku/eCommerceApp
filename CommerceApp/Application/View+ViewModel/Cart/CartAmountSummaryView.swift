//
//  CartAmountSummaryView.swift
//  CommerceApp
//
//  Created by Md Abdul Gafur on 11/8/23.
//

import SwiftUI

import SwiftUI
import RealmSwift

struct CartAmountSummaryView: View {
    @ObservedResults(ProductRealm.self) var productRealm
    
    var body: some View {
        VStack(alignment:.leading,spacing: 10) {
            HStack{
                UrbanistRegularTextView(text: "Sub Total", fontSize: 16, colorName: "000000")
                Spacer()
                UrbanistRegularTextView(text: "\(String(format: "%.2f", (RealmManager.getSubTotal(productRealm: self.productRealm))))", fontSize: 16, colorName: "000000")
            }
            HStack{
                UrbanistRegularTextView(text: "Delivery fee", fontSize: 14, colorName: "000000")
                Spacer()
                UrbanistRegularTextView(text: "\(RealmManager.getDeliveryCharge(productRealm: productRealm))", fontSize: 14, colorName: "000000")
            }
            
            HStack{
                UrbanistRegularTextView(text: "Discount", fontSize: 14, colorName: "000000")
                Spacer()
                UrbanistRegularTextView(text: "\(String(format: "%.2f", (RealmManager.getDiscount(productRealm: self.productRealm))))", fontSize: 14, colorName: "000000")
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct CartAmountSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        CartAmountSummaryView()
    }
}
