//
//  ProductRealm.swift
//  CommerceApp
//
//  Created by Md Abdul Gafur on 11/8/23.
//

import Foundation
import RealmSwift

class ProductRealm : Object , Identifiable {
    @Persisted(primaryKey: true) var objectId:ObjectId
   
    @Persisted var id:String
    @Persisted var name:String?
    @Persisted var productImage:String?
    @Persisted var variation:VariationRealm?
    @Persisted var shopId:String?
    @Persisted var shop:ShopRealm?
    @Persisted var hubId:String?
    @Persisted var slug:String?
    @Persisted var quantity:Int
    @Persisted var isSelected:Bool?
    @Persisted var barCode:String?
    @Persisted var isDelect:Bool?
    @Persisted var vat:Double?
    @Persisted var sd:Bool?
  
    override class func primaryKey() -> String? {
        "objectId"
    }
}

extension ProductRealm {
    
  
    
    var getIsSelected:Bool {
        guard let isSelected = self.isSelected else {
            return false
        }
        return isSelected
    }
    
    var getShopIsSelected:Bool {
        guard let isSelected = self.shop?.isSelected else {
            return false
        }
        return isSelected
    }

    var getShopId:String{
        guard let id = self.shop?.id else {
            return ""
        }
        return id
    }
    

    
    var getShopName:String {
        guard let name = self.shop?.name else {
            return ""
        }
        return name
    }
    

    
    var getShopType:String {
        guard let type = self.shop?.type else {
            return ""
        }
        return type
    }
    
    
    var getProductImage:String {
        guard let productImage = self.productImage else {
            return ""
        }
        return productImage
    }
    
    var getName:String {
        guard let name = self.name else {return ""}
        return name
    }
    
    var getVariationId:String {
        guard let variationId = self.variation?.variationId else {return ""}
        return variationId
    }
    
    var getVariationName:String {
        guard let variationName = self.variation?.variationName  else {return ""}
        return variationName
    }
    
    var getMrp:Double {
        guard let mrp = self.variation?.price?.mrp  else {
            return 0.0
        }
        return mrp
    }
    
    var getVat:Double {
        guard let mrp = self.vat  else {
            return 0.0
        }
        return mrp
    }
    
    var getDiscountedPrice:Double {
        guard let discountedPrice = self.variation?.price?.discountedPrice else { return 0.0 }
        return discountedPrice
    }
    
    var getMaximumCartLimit:Int {
        return  self.variation?.getMaximumCartLimit ?? 0
        
    }
    
    var getIsShopFreeDelivery:Bool {
        guard let isFreeDelivery = self.shop?.isFreeDelivery else {return false}
        return isFreeDelivery
    }
    
    var getShopBaseDeliveryCharge:Double {
        guard let baseDeliveryCharge = self.shop?.baseDeliveryCharge else {return 0.0}
        return baseDeliveryCharge
    }
    
    
    
    var getShopMinimumAmountForFreeDelivery:Double {
        guard let minimumAmountForFreeDelivery = self.shop?.minimumAmountForFreeDelivery  else { return 0.0}
        return minimumAmountForFreeDelivery
    }
}


class VariationRealm : Object , Identifiable {
    @Persisted(primaryKey: true) var objectId:ObjectId
    @Persisted var variationId:String?
    @Persisted var variationName:String?
    @Persisted var stock:Int?
    @Persisted var maximumOrderLimit:Int?
    @Persisted var price:PriceRealm?
    
    
    override class func primaryKey() -> String? {
        "objectId"
    }
}

extension VariationRealm {
    
    var getStock:Int {
        guard let stock = self.stock else {return 0}
        return stock
    }
    
    var getMaximumOrderLimit:Int {
        guard let maximumOrderLimit = self.maximumOrderLimit else {return 0}
        return maximumOrderLimit
    }
    
    var getMaximumCartLimit:Int {
        return getMaximumOrderLimit > 0 ? (getMaximumOrderLimit > getStock ? getStock :  getMaximumOrderLimit )  : getStock
    }
    
}


class PriceRealm : Object , Identifiable {
    @Persisted(primaryKey: true) var objectId:ObjectId
    @Persisted var mrp:Double?
    @Persisted var discountedPrice:Double?
    
    override class func primaryKey() -> String? {
        "objectId"
    }
}

class ShopRealm : Object , Identifiable {
    @Persisted(primaryKey: true) var objectId:ObjectId
    
    @Persisted var id:String?
    @Persisted var name:String?
    @Persisted var logo:String?
    @Persisted var banner:String?
    @Persisted var isSelected:Bool?
    @Persisted var type:String?
    @Persisted var isFreeDelivery:Bool?
    @Persisted var baseDeliveryCharge:Double?
    @Persisted var vat:Double?
    @Persisted var minimumAmountForFreeDelivery:Double?
    @Persisted var deliveryCharge:Double?
   
    
    override class func primaryKey() -> String? {
        "objectId"
    }
}

