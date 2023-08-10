//
//  BIEndpoint.swift
//  DhamakaShopping
//
//  Created by Invariant on 2/2/21.
//

import Foundation
import Alamofire

protocol DSEndpoint {
    var method:HTTPMethod { get }
    var path:String { get }
    var query:[String:Any] { get }
    var encoding: ParameterEncoding {get set}
}

extension DSEndpoint {
    var encoding:ParameterEncoding {get {
        if(method.rawValue == "GET"){
            return URLEncoding(boolEncoding: .literal)
        }else {
            //return URLEncoding(boolEncoding: .literal)
            return JSONEncoding.default
        }
    } set{}}
}

