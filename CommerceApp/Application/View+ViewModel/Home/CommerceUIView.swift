//
//  CommerceUIView.swift
//  CommerceApp
//
//  Created by RootNext15 on 10/8/23.
//

import SwiftUI

struct CommerceUIView: View {
    @Environment(\.presentationMode) var presentationMode:Binding<PresentationMode>
    @StateObject var viewModel = FashionViewModel()
    var body: some View {
        NavigationView{
            VStack{
                VStack(spacing:0) {
                    HStack{
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image("back_black_icon")
                        }
                        Spacer()
                        
                        
                        UrbanistSemiBoldTextView(text: "E-Commerce", fontSize: 16, colorName: "000000")
                        Spacer()
                        
                    }
                    .padding(.horizontal,15)
                    .padding(.vertical, 5)
                    .background(Color.white)
                }
                VStack{
                    ScrollView(.vertical,showsIndicators: false){
                        if(viewModel.categories.count > 0){
                            FixedGridView(itemCount: viewModel.categories.count, columnCount: 4, cellSpacing: 5) { index in
                                let category = viewModel.categories[index]
                                
                                NavigationLink(destination: CategoryDetailsView(categoryName:category.getTitle,categoryId: category.getId)) {
                                    CommerceCategoryCellView(imageString: category.getImage, name: category.getTitle)
                                }
                            }
                        }
                    }
                }
                .padding([.leading,.trailing],25)
            }
            .onAppear {
                viewModel.getCategories()
            }
        }
    }
}

struct CommerceUIView_Previews: PreviewProvider {
    static var previews: some View {
        CommerceUIView()
    }
}
