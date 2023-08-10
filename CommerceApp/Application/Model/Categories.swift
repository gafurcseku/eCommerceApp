//
//  Categories.swift
//  Jachai
//
//  Created by Gafur on 11/10/21.
//

import Foundation
import ObjectMapper

struct Categories : Mappable {
    var message:String?
    var statusCode:Int?
    var categories:[Categorie]?
  
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        message <- map["message"]
        statusCode <- map["statusCode"]
        categories <- map["categories"]
    }
}


extension Categories {

    var getCategories:[Categorie] {
        guard let categories = self.categories else {
            return []
        }
        return categories
    }
}

struct Categorie:Mappable,Hashable, Identifiable{
    var id:String?
    var title:String?
    var image:String?
    var isSelect:Bool?
    
    init?(map: Map) {
        
    }
    
    init(title:String?, isSelect:Bool?){
        self.title = title
        self.isSelect = isSelect
    }
    
    init(title:String?,image:String?){
        self.title = title
        self.image = image
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        image <- map["image"]
    }
}

extension Categorie {
    
    var getId:String {
        guard let id = self.id else {
            return ""
        }
        return id
    }
    
    var getTitle:String {
        guard let title = self.title else {
            return ""
        }
        return title
    }
    
    var getImage:String{
        guard let image = self.image else {
            return ""
        }
        return image
    }
    
    var getIselected:Bool {
        guard let isSelect = self.isSelect else {return false}
        return isSelect
    }
    
}
