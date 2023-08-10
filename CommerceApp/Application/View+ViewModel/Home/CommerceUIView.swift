//
//  CommerceUIView.swift
//  CommerceApp
//
//  Created by RootNext15 on 10/8/23.
//

import SwiftUI

struct CommerceUIView: View {
    
    @StateObject var viewModel = FashionViewModel()
    
    @State private var showingOptions = false
       @State private var shouldPresentImagePicker = false
       @State private var shouldPresentCamera = false
       @State private var image: Image? = Image("photo")
    
    var body: some View {
        NavigationView{
            VStack{
                VStack(spacing:0) {
                    HStack{
                        
                        Spacer()
                        
                        
                        UrbanistSemiBoldTextView(text: "E-Commerce", fontSize: 16, colorName: "000000")
                        Spacer()
                        
                        Button {
                            showingOptions.toggle()
                        } label: {
                            if let image = self.image {
                                image.resizable().frame(width: 25,height: 25)
                            }
                            
                        }

                        
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
            .sheet(isPresented: $shouldPresentImagePicker) {
                       GYTDImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary,image: self.$image,isPresented:self.$shouldPresentImagePicker) { ( isSuccess, data) in
                           if(isSuccess){
                               if let image = data {
                                  
                               }
                           }
                       }
                       
                   }
            .actionSheet(isPresented: self.$showingOptions){
                      ActionSheet( title: Text("Select a option"),  buttons: [
                          .default(Text("Camera")) {
                              self.shouldPresentImagePicker = true
                              self.shouldPresentCamera = true
                          },
                          
                              .default(Text("Gallery")) {
                                  self.shouldPresentImagePicker = true
                                  self.shouldPresentCamera = false
                              },
                          
                          ActionSheet.Button.cancel()
                      ])
                  }
        }
    }
}

struct CommerceUIView_Previews: PreviewProvider {
    static var previews: some View {
        CommerceUIView()
    }
}
