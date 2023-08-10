//
//  CategoryDetailsView.swift
//  CommerceApp
//
//  Created by RootNext15 on 10/8/23.
//

import SwiftUI

struct CategoryDetailsView: View {
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    @StateObject private var viewModel = FashionViewModel()
    
    var categoryName:String = "No Category"
    var categoryId:String = ""
    
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("back_black_icon")
                }
                Spacer()
                HStack(spacing:5){
                    UniNeueRegularTextView(text: categoryName, fontSize: 18, colorName: "3A494E")
                }
            }
            .padding([.leading,.trailing],15)
            .padding([.top,.bottom], 10)
            .background(Color.white)
            
            if(viewModel.allProducts.productList.count > 0){
                ScrollView(.vertical,showsIndicators: false){
                    LazyGridView(itemCount:  viewModel.allProducts.productList.count, columnCount: 2, cellSpacing: 5) { index in
                        let product = viewModel.allProducts.productList[index]
                        NavigationLink(destination:  ProductDetailsView(slug: product.getSlug)){
                            ProductCellUIView(imageString: product.getProductImage, name: product.getName, selling: product.getVariations.getPrice.getNewPrice, price: product.getVariations.getPrice.getOldPrice, discountType: product.getVariations.getProductDiscount.getDisCountType, stock: product.getVariations.getStock, imageCount: 2)
                        }.isDetailLink(false)
                    } canLoadNext: {
                        viewModel.getCategoryProduct(categoryId: self.categoryId)
                        
                    }
                }
                .padding([.leading,.trailing],25)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear{
            viewModel.getCategoryProduct(categoryId: self.categoryId)
        }
    }
}

struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryDetailsView()
    }
}
