//
//  CartView.swift
//  CommerceApp
//
//  Created by Md Abdul Gafur on 11/8/23.
//

import SwiftUI
import RealmSwift

struct CartView: View {
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    @ObservedResults(ProductRealm.self) var productRealm
    var body: some View {
            VStack{
                VStack{
                    HStack {
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                                Image("back_black_icon")
                        }
                        VStack(alignment:.leading){
                            UrbanistSemiBoldTextView(text: "Cart Item", fontSize: 14, colorName: "000000")
                            let distinctShop  =  RealmManager.getDistinct(productRealm: self.productRealm)
                            if(!distinctShop.isEmpty){
                                
                                UrbanistRegularTextView(text:distinctShop[0].getShopName, fontSize: 12, colorName: "000000")
                            }
                           
                        }
                        
                        Spacer()
                        
                        if(productRealm.count > 0){
                            Button {
                                RealmManager.RemoveProductRealm() { isSuccess in
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            } label: {
                                HStack{
                                    UrbanistSemiBoldTextView(text: "Clear Cart", fontSize: 14, colorName: "000000")
                                    Image(systemName: "trash.fill").resizable().frame(width: 20, height: 20, alignment: .center)
                                        .foregroundColor(Color("000000"))
                                }
                            }
                        }
                    }
                    .padding(15)
                    .background(Color("FFFFFF"))
                }
                .padding([.top],48)
               
                
                if(productRealm.count > 0){
                    VStack {
                        ScrollView(.vertical, showsIndicators: false) {
                            CartProductView()
                            CartAmountSummaryView()
                        }
                    }
                    CartCheckOutView()
                }
                Spacer()
            }
        .background(Color("F8F8F8"))
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
       
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
