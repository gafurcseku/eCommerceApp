//
//  FashionViewModel.swift
//  CommerceApp
//
//  Created by RootNext15 on 10/8/23.
//

import Foundation

class FashionViewModel : ObservableObject {
    
    @Published var categories:[Categorie] = []
    
    func getCategories(typeOfService:String)  {
        APIClient.shared.objectAPICall(apiEndPoint: FashionApiEndPoint.category(typeOfService: typeOfService), modelType: Categories.self) { result in
            
            switch result {
            case .success(let data):
                self.categories = data.getCategories
            case .failure((let code,let data,let error)):
                print(code)
                print(data as Any)
               
            }
            
        }
    }
    
    
}
