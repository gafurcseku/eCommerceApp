//
//  Shops.swift
//  Jachai
//
//  Created by Gafur on 11/10/21.
//

import Foundation
import ObjectMapper

struct Shops : Mappable {
    var message:String?
    var totalElements:Int?
    var shops:[Shop]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        message <- map["message"]
        totalElements <- map["totalElements"]
        shops <- map["shops"]
    }
}

extension Shops {
    var getTotalElements:Int {
        guard let totalElements = self.totalElements else {
            return 0
        }
        return totalElements
    }
}

struct TimeSlots : Mappable,Hashable {
    var from:String?
    var to:String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        from <- map["from"]
        to <- map["to"]
    }
}

extension TimeSlots {
    var getFrom:String {
        guard let from = self.from else {
            return ""
        }
        return from
    }
    
    var getTo:String {
        guard let to = self.to else {
            return ""
        }
        return to
    }
}

struct Shop : Mappable,Hashable {
    var id:String?
    var name:String?
    var description:String?
    var logo:String?
    var banner:String?
    var status:String?
    var type:String?
    var isFreeDelivery:Bool?
    var baseDeliveryCharge:Double?
    var vat:Double?
    var minimumAmountForFreeDelivery:Double?
    var rating:Double?
    var timeRemaining:Int?
    var deliveryCharge:Double?
    var timeSlots:[TimeSlots]?
    
    init?(map: Map) {
        
    }
    
    init(id:String? ,name:String? ,logo:String? , isFreeDelivery:Bool?,baseDeliveryCharge:Double?, vat:Double?, minimumAmountForFreeDelivery:Double?) {
        self.id = id
        self.name = name
        self.logo = logo
        self.isFreeDelivery = isFreeDelivery
        self.vat = vat
        self.baseDeliveryCharge = baseDeliveryCharge
        self.minimumAmountForFreeDelivery = minimumAmountForFreeDelivery
    }
    
    init(){
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        id <- map["_id"]
        name <- map["name"]
        description <- map["description"]
        logo <- map["logo"]
        banner <- map["banner"]
        status <- map["status"]
        isFreeDelivery <- map["isFreeDelivery"]
        baseDeliveryCharge <- map["baseDeliveryCharge"]
        vat <- map["vat"]
        type <- map["type"]
        minimumAmountForFreeDelivery <- map["minimumAmountForFreeDelivery"]
        rating <- map["rating"]
        timeRemaining <- map["timeRemaining"]
        deliveryCharge <- map["deliveryCharge"]
        timeSlots <- map["timeSlots"]
    }
    
}

extension Shop {
    
  

    var getTimeSlots:[TimeSlots] {
        guard let timeSlots = self.timeSlots else {
            return []
        }
        return timeSlots
    }
    
    var getType:String{
        guard let type = self.type else {
            return ""
        }
        return type
    }
    
    var getId:String{
        guard let id = self.id else {
            return ""
        }
        return id
    }
    
    var getName:String {
        guard let name = self.name else {
            return ""
        }
        return name
    }
    
    var getDescription:String {
        guard let description = self.description else {
            return ""
        }
        return description
    }
    
    var getLogo:String{
        guard let logo = self.logo else {
            return ""
        }
        return logo
    }
    
    var getBanner:String {
        guard let banner = self.banner else {
            return ""
        }
        return banner
    }
    
    var getStatus:String{
        guard let status = self.status else {
            return ""
        }
        return status
    }
    
    var getIsFreeDelivery:Bool {
        guard let isFreeDelivery = self.isFreeDelivery else {return false}
        return isFreeDelivery
    }
    
    var getBaseDeliveryCharge:Double {
        guard let baseDeliveryCharge = self.baseDeliveryCharge else {return 0.0}
        return baseDeliveryCharge
    }
    
    var getVat:Double {
        guard let vat = self.vat  else {return 0.0}
        return vat
    }
    
    var getMinimumAmountForFreeDelivery:Double {
        guard let minimumAmountForFreeDelivery = self.minimumAmountForFreeDelivery  else { return 0.0}
        return minimumAmountForFreeDelivery
    }
    
    var getRating:Double {
        guard let rating = self.rating else {
            return 0.0
        }
        return rating
    }
    
    var getTimeRemaining:Int {
        guard let timeRemaining = self.timeRemaining else {
            return 0
        }
        return timeRemaining
    }
    
    var getDeliveryCharge:Double {
        guard let deliveryCharge = self.deliveryCharge else {
            return 0.0
        }
        return deliveryCharge
    }
}
