//
//  ProductDetailsView.swift
//  Jachai
//
//  Created by Gafur on 9/11/21.
//

import SwiftUI
import SDWebImageSwiftUI


struct ProductDetailsView: View {
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    @StateObject var viewModel = ProductDetailsViewModel()
    var slug:String = "Pran-Apple-Fruit-Juice-ml-3Rw4"
    @State var index = 0
    
    var body: some View {
        
        VStack(spacing:0) {
            HStack{
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image("back_black_icon")
                }
                
                Spacer()
            }
            .padding([.leading,.trailing],15)
            .padding([.top,.bottom], 15)
            .background(Color.white)
            
            if let product = viewModel.product {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment:.leading){
                        ProductDetailsSliderUIView(index: self.$index, imageCount: product.getImages.count - 1, images: product.getImages)
                        
                        VStack(alignment:.leading) {
                            HStack(alignment:.center){
                                UniNeueBoldTextView(text: product.getName, fontSize: 26, colorName: "000000")
                                Spacer()
                            }
                            
                            HStack{

                                UniNeueBoldTextView(text: "BDT \(viewModel.fashionVariation.getPrice.getNewPrice)", fontSize: 20, colorName: "000000")
                                if(viewModel.fashionVariation.getPrice.getOldPrice > 0.0 ) {
                                    UniNeueRegularTextView(text: "BDT \(viewModel.fashionVariation.getPrice.getOldPrice)", fontSize: 14, colorName: "000000",strikethrough: true)
                                }
                                if(viewModel.fashionVariation.getProductDiscount.getDisCountType != ""){
                                    UniNeueRegularTextView(text: product.getVariations.getProductDiscount.getDisCountType, fontSize: 14, colorName: "000000")
                                        .padding(5)
                                        .background(Color.white.opacity(0.1))
                                        .cornerRadius(3)
                                }
  
                            }
                            
                            ProductVariantView(variantions: product.getVariationList,viewModel:self.viewModel)
                            
                            let html = "<span style=\"font-size: 18\">\(product.getDescription)</span>"
                            
                            HTMLFormattedText(html)
                        }
                        .padding([.leading,.trailing],15)
                    }
                }
                
                Spacer()
                                    ProductDetailsFooterView(viewModel:self.viewModel,product:product)
                                        .padding([.leading,.trailing],15)
                                        .padding([.leading,.trailing],15)
            }else {
                VStack(alignment:.leading){
                    Image("Image_placeholder").resizable().frame(width:UIScreen.main.bounds.width,height: 315, alignment: .center).aspectRatio(contentMode: .fit)
                    VStack(alignment:.leading) {
                        HStack(alignment:.firstTextBaseline){
                            UniNeueBoldTextView(text: "Pran Mr. Noodles Easy Instant Noodles (16 pcs/pack) [ Free Jurry Box]", fontSize: 26, colorName: "000000")
                            
                        }
                        HStack{
                            UniNeueBoldTextView(text: "BDT 345.00", fontSize: 20, colorName: "000000")
                            UniNeueRegularTextView(text: "BDT 567.00", fontSize: 14, colorName: "000000")
                                .padding(5)
                        }
                        UniNeueRegularTextView(text: "Pran Mr. Noodles Easy Instant Noodles \n Brand:Mr. pran \n Product Type: Noodles \n Weight:16pcs", fontSize: 14, colorName: "000000").multilineTextAlignment(.leading)
                            .padding(.top,15)
                    }
                    .padding([.leading,.trailing],15)
                }.redacted(reason: .placeholder)
            }
            
            Spacer()
            
            
        }
        
        .onAppear(perform: {
            viewModel.getProduct(slug: self.slug)
            
        })
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
        
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(slug:"Hotel-Media-International-diAO")
    }
}
