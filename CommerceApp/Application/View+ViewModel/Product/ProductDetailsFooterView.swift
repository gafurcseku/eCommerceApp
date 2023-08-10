//
//  ProductDetailsFooterView.swift
//  CommerceApp
//
//  Created by Md Abdul Gafur on 10/8/23.
//

import SwiftUI
import RealmSwift

struct ProductDetailsFooterView: View {
    @State private var isPresent:Bool = false
    @ObservedObject var viewModel:ProductDetailsViewModel
    @State  var number:Int = 1
    @ObservedResults(ProductRealm.self) var productRealm
    var product:Product = Product.init()
    
    
    @State private var showToast:Bool = false
    @State private var toastMessage:String = ""
    
    @State private var productAdd:Bool = false
    @State private var productAddMessage:String = ""
    
    var body: some View {
        HStack(spacing:10){
            if(product.getVariations.getStock > 0){
                let productCount = RealmManager.getProductCount(productRealm: self.productRealm, product: product, variation: viewModel.fashionVariation )
                if(productCount > 0){
                    NavigationLink(destination: CartView()) {
                        HStack{
                            UniNeueBoldTextView(text: "View Cart", fontSize: 14, colorName: "FFFFFF")
                        }
                        .padding([.leading,.trailing],35)
                        .padding([.top,.bottom],10)
                        .background(Color("3A494E"))
                        .cornerRadius(6)
                        Spacer()
                    }.isDetailLink(false)
                    
                }
                CustomerStepperView(minValue: 1, maxValue: product.getMaxLimit(), defaultValue: productCount > 0 ? productCount : 1 , isDisable: true) { itemCount in
                    self.number = itemCount
                    if(productCount > 0){
                        save()
                    }
                }
                
                if(productCount <= 0){
                    Spacer()
                    Button {
                        save()
                    } label: {
                        UniNeueBoldTextView(text: "Add to Cart", fontSize: 16, colorName: "FFFFFF")
                    }
                    .padding([.leading,.trailing],35)
                    .padding([.top,.bottom],10)
                    .background(Color("3A494E"))
                    .cornerRadius(6)
                }
                
            }else{
                Spacer()
                UniNeueRegularTextView(text: "Out of Stock", fontSize: 18, colorName: "000000")
                Spacer()
            }
            
        }
        
    }
    
    fileprivate func save() {
        saveProduct(productRealm: self.productRealm, product: product, variation: viewModel.fashionVariation)
    }
    
    
    fileprivate func saveProduct(productRealm:RealmSwift.Results<ProductRealm>,product:Product, variation:Variations) {
        RealmManager.checkProduct(productRealm: self.productRealm, product: product, variation: variation) { duplicateShop , duplicateProduct in
            if(duplicateShop){
                self.isPresent = true
            }else if(duplicateProduct){
                RealmManager.UpdateProduct(product: product, variation: variation,updateValue: self.number)
            }else {
                $productRealm.append(RealmManager.getProduct(product: product, variation: variation,updateValue: self.number))
            }
        }
    }
    
    
}

struct ProductDetailsFooterView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsFooterView(viewModel: ProductDetailsViewModel())
    }
}
