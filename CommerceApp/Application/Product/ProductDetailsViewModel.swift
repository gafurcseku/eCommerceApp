//
//  ProductDetailsViewModel.swift
//  Jachai
//
//  Created by Gafur on 9/11/21.
//

import Foundation


class ProductDetailsViewModel : ObservableObject {
    @Published var isLoading:Bool = false
    @Published var product:Product? = nil
    @Published var fashionVariation:Variations = Variations.init()
    
    func getProduct(slug:String){
        self.isLoading = true
        APIClient.shared.objectAPICall(apiEndPoint: FashionApiEndPoint.getProduct(slug: slug), modelType: ProductDetails.self) { result in
            self.isLoading = false
            print(result)
            switch result {
            case .success(let data):
                self.product = data.product
            case .failure((let code,let data,let error)):
                print(code)
                print(data as Any)
               
                break
            }
        }
    }
    
    
}
