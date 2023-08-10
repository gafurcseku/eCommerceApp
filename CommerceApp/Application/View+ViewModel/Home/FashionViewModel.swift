//
//  FashionViewModel.swift
//  CommerceApp
//
//  Created by RootNext15 on 10/8/23.
//

import Foundation

class FashionViewModel : ObservableObject {
    
    @Published var categories:[Categorie] = []
    
    func getCategories()  {
        APIClient.shared.objectAPICall(apiEndPoint: FashionApiEndPoint.category, modelType: Categories.self) { result in
            
            switch result {
            case .success(let data):
                self.categories = data.getCategories
            case .failure((let code,let data,let error)):
                print(code)
                print(data as Any)
                
            }
            
        }
    }
    
    struct AllProductsState {
        var productList: [Product] = []
        var page: Int = 0
        var canLoadNextPage = true
    }
    
    
    @Published  var allProducts = AllProductsState()
    @Published var productEmpty:Bool = false
    func getCategoryProduct(categoryId:String,isRemove:Bool = false){
        if(isRemove){
            self.allProducts.productList = []
            self.allProducts.page = 0
            self.allProducts.canLoadNextPage = false
        }
        
        APIClient.shared.objectAPICall(apiEndPoint: FashionApiEndPoint.categoryProducts(categoryId: categoryId,page: allProducts.page,limit: 6), modelType: ProductCategory.self) { result in
            switch result {
            case .success(let data):
                if let populars = data.products {
                    self.allProducts.productList += populars
                    if(self.allProducts.productList.count >= 0){
                        self.productEmpty = true
                    }
                    if(!populars.isEmpty){
                        self.allProducts.page += 1
                        self.allProducts.canLoadNextPage = true
                    }else{
                        self.allProducts.canLoadNextPage = false
                    }
                }else{
                    self.allProducts.canLoadNextPage = false
                }
            case .failure((let code,let data,let error)):
                print(code)
                print(data as Any)
                
            }
        }
    }
    
    
}
