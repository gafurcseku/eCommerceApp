//
//  ProductVariantView.swift
//  CommerceApp
//
//  Created by Md Abdul Gafur on 10/8/23.
//

import SwiftUI

struct ProductVariantView: View {
    @State var variantions:[Variations] = []
    @State var selectedIndex:Int  = 0
    @ObservedObject var viewModel:ProductDetailsViewModel = ProductDetailsViewModel()
    
    var body: some View {
        VStack(alignment:.leading){
            UniNeueBoldTextView(text: "Variations", fontSize: 16, colorName: "000000")
            HStack{
                ForEach(0..<variantions.count, id: \.self) { index in
                    let variant = variantions[index]
                    HStack{
                        VStack{
                            UniNeueBoldTextView(text: variant.getVariationName, fontSize: 13, colorName: variant.getIsSelected ? "FFFFFF" : "000000")
                        }
                        .padding([.leading,.trailing],12)
                        .padding([.top,.bottom],6)
                        .background(variant.getIsSelected ? Color("FF0000") : Color("FFFFFF"))
                        .cornerRadius(6)
                        .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color("BDBDBD"), lineWidth: 1))
                        .onTapGesture {
                            if(self.selectedIndex != index){
                                self.variantions[selectedIndex].isSelected = false
                                self.variantions[index].isSelected = true
                                self.selectedIndex = index
                                self.viewModel.fashionVariation = variant
                            }
                            
                        }
                    }
                }
                .onAppear {
                    self.variantions[self.selectedIndex].isSelected = true
                    self.viewModel.fashionVariation = self.variantions[self.selectedIndex]
                }
                
                UniNeueRegularTextView(text: "Size Info", fontSize: 12, colorName: "000000")
            }
        }
    }
}

struct ProductVariantView_Previews: PreviewProvider {
    static var previews: some View {
        ProductVariantView(variantions: [Variations(variationId: "aaaa", variationName: "AA", stock: 1, maximumOrderLimit: 1, price: nil, productDiscount: nil)])
    }
}
