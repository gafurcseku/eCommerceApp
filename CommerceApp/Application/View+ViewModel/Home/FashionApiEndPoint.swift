//
//  FashionApiEndPoint.swift
//  CommerceApp
//
//  Created by RootNext15 on 10/8/23.
//

import Foundation
import Alamofire

enum FashionApiEndPoint : DSEndpoint {
   
    case category()
    
    
    var method: HTTPMethod {
        switch self {
        case .category:
            return .get
        }
    }
    
    
    var path: String {
        switch self {
  
        case .category:
            return ProductBaseUrl+ApiPath.category_type.rawValue
       
        }
    }
    
    var query: [String : Any]{
        switch self {
       
        case .category(let typeOfService):
            return [String:Any]()
        
        }
    }
    
    
}
