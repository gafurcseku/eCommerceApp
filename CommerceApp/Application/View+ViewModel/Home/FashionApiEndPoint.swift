//
//  FashionApiEndPoint.swift
//  CommerceApp
//
//  Created by RootNext15 on 10/8/23.
//

import Foundation
import Alamofire

enum FashionApiEndPoint : DSEndpoint {
   
    case category
    case categoryProducts(categoryId:String? = nil,page:Int,limit:Int)
    case getProduct(slug:String)
    
    var method: HTTPMethod {
        switch self {
        case .category,.categoryProducts,.getProduct:
            return .get
        }
    }
    
    
    var path: String {
        switch self {
  
        case .category:
            return ProductBaseUrl+ApiPath.category_type.rawValue
        case .categoryProducts:
            return ProductBaseUrl + ApiPath.productsbyparentcategory.rawValue
        case .getProduct(slug:let slug):
            return ProductBaseUrl+ApiPath.productDetails.rawValue+"?slug=\(slug)"
        }
    }
    
    var query: [String : Any]{
        switch self {
        case .category,.getProduct:
            return [String:Any]()
        case .categoryProducts(let categoryId,let page, let limit):
                   var query:[String:Any] = [:]
                   
                   
                   if(categoryId != nil){
                       query["categoryId"] = categoryId!
                   }
                   
                   
                   query["page"] = page
                   query["limit"] = limit
                   return query
        
        }
    }
    
    
}
