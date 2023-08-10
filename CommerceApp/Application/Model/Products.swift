//
//  Products.swift
//  Qccom
//
//  Created by Gafur on 13/10/21.
//

import Foundation
import ObjectMapper

struct Products : Mappable {
    var message:String?
    var totalPages:Int?
    var currentPageNumber:Int?
    var products:[ProductCategory]?
    var productCategories:[ProductCategory]?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        message <- map["message"]
        totalPages <- map["totalPages"]
        currentPageNumber <- map["currentPageNumber"]
        products <- map["products"]
        productCategories <- map["productCategories"]
    }
}

extension Products {
    var getTotalPages:Int {
        guard let totalPages = self.totalPages else {
            return 0
        }
        return totalPages
    }
    
    var getCurrentPageNumber:Int {
        guard let currentPageNumber = self.currentPageNumber else {return 0}
        return currentPageNumber
    }
}

struct ProductDetails : Mappable {
    var message:String?
    var product:Product?
    var addons:[AddOns]?
   
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        message <- map["message"]
        product <- map["product"]
        addons <- map["addons"]
    }
}

struct ProductCategory :Mappable {
    var categoryId:String?
    var category:String?
    var selected:Bool?
    var products:[Product]?
   
    init(category:String,selected:Bool) {
        self.selected = selected
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        categoryId <- map["categoryId"]
        category <- map["category"]
        products <- map["products"]
    }
}

extension ProductCategory {
    var getCategoryId:String {
        guard let categoryId = self.categoryId else {return ""}
        return categoryId
    }
    var getCategory:String {
        guard let category = self.category  else {
            return ""
        }
        return category
    }
    
    var getSelected:Bool {
        guard let selected = self.selected else {
            return false
        }
        return selected
    }
    
    var getProducts:[Product] {
        guard let products = self.products else {
            return []
        }
        return products
    }
}

struct Product:Mappable {
    var id:String?
    var name:String?
    var productImage:String?
    var isPopular:Bool?
    var variations:[Variations]?
    var variation:Variations?
    var images:[String]?
    var description:String?
    var shopId:String?
    var shop:Shop?
    var slug:String?
    var qty:Int?
    var quantity:Int?
    var isSelected:Bool?
    var feedbackId:String?
    var barCode:String?
    var productShopType:String?
    var isSDApplicable:Bool?
    
    init?(map: Map) {
        
    }
    
    init(id:String?,name:String?,productImage:String?,qty:Int?,variantId:String?,variantName:String?,mrp:Double?,discount:Double?,stock:Int?,maximumOrderLimit:Int?,flat:Int?, percentage:Int?,productShopType:String?) {
        self.id = id
        self.name = name
        self.productImage = productImage
        self.qty = qty
        self.variation = Variations.init(variationId: variantId,variationName: variantName,stock: stock,maximumOrderLimit: maximumOrderLimit ,price: Price(mrp: mrp, discountedPrice: discount),productDiscount: ProductDiscount.init(flat: flat, percentage: percentage))
        self.productShopType = productShopType
    }
    
    init(){
        
    }
    

    
    mutating func mapping(map: Map) {
        id <- map["id"]
        id <- map["_id"]
        
        name <- map["name"]
        name <- map["_source.name"]
        
        productImage <- map["productImage"]
        
        productImage <- map["_source.productImage"]
        
        isPopular <- map["isPopular"]
        isPopular <- map["_source.isPopular"]
        
        variations <- map["variations"]
        variations <- map["_source.variations"]
        
        variation <- map["variation"]
        
        images <- map["images"]
        images <- map["_source.images"]
        
        description <- map["description"]
        description <- map["_source.description"]
        
        shopId <- map["shopId"]
        shopId <- map["_source.shopId"]
        
       
        
        slug <- map["slug"]
        slug <- map["_source.slug"]
        
        shop <- map["shop"]
        shop <- map["_source.shop"]
        
     
        
        quantity <- map["quantity"]
       
        
        barCode <- map["barCode"]
        barCode <- map["_source.barCode"]
        
        isSDApplicable <- map["isSDApplicable"]
        
    }
}

extension Product {
    
    var getIsSDApplicable:Bool {
        guard let isSDApplicable = self.isSDApplicable else { return false}
        return isSDApplicable
    }

    var getProductShopType:String {
        guard let productShopType = self.productShopType else {
            return ""
        }
        return productShopType
    }
    
    var getBarCode:String {
        guard let barCode = self.barCode else {
            return ""
        }
        return barCode
    }
    var getFeedbackId:String {
        guard let feedbackId = self.feedbackId else {
            return ""
        }
        return feedbackId
    }
    var getISselected:Bool {
        guard let isSelected = self.isSelected else {
            return false
        }
        return isSelected
    }
    var getId:String {
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
    
    var getProductImage:String {
        guard let productImage = self.productImage else {
            return ""
        }
        return productImage
    }
    
    var getVariations:Variations {
        if(self.variations?.count ?? 0 > 0){
            guard let variations = self.variations?[0] else {return Variations.init()}
            return variations
        }else{
            return Variations.init()
        }
        
    }
    
    var getVariationList:[Variations] {
        guard let variations = self.variations else {return []}
        return variations
    }
    
    var getVariation:Variations {
        guard let variations = self.variation else {return Variations.init()}
        return variations
    }
    
    func getVariation(_ index:Int) -> Variations {
        guard let variations = self.variations?[index] else {return Variations.init()}
        return variations
    }
    
    var getDescription:String {
        guard let description = self.description else { return ""}
        return description
    }
    
    var getImages:[String] {
        guard var images = self.images else { return []}
        if(images.isEmpty){
            images += [getProductImage]
        }
        return images
    }
    
    var getShopId:String {
        guard let shopId = self.shopId else { return ""}
        return shopId
    }
    
    
    
    var getSlug:String {
        guard let slug = self.slug  else { return ""}
        return slug
    }
    
    func getVariationId(_ index:Int) -> String {
        return self.variations?[0].variationId ?? ""
    }
    
    func getMrp(_ index:Int) -> Double {
        return self.variations?[0].price?.getMrp ?? 0.0
    }
    

    
    func getDiscountedPrice(_ index:Int) -> Double {
        return self.variations?[0].price?.getDiscountedPrice ?? 0.0
    }
    
    var getQty:Int {
        guard let qty = self.qty else { return 0}
        return qty
    }
    
    var getQuantity:Int{
        guard let quantity = self.quantity else {return 0}
        return quantity
    }
    
    var getShop:Shop {
        guard let shop = self.shop else { return Shop.init()}
        return shop
    }
    
 
    func getMaxLimit() -> Int{
        if(getVariations.getVariationId == "Discounted"){
            var max = 0
            for variantion in getVariationList {
                max += variantion.getMaximumOrderLimit > 0 ? (variantion.getMaximumOrderLimit > variantion.getStock ? variantion.getStock :  variantion.getMaximumOrderLimit )  : variantion.getStock
            }
            return max
        }else{
            return getVariations.getMaximumOrderLimit > 0 ? (getVariations.getMaximumOrderLimit > getVariations.getStock ? getVariations.getStock :  getVariations.getMaximumOrderLimit )  : getVariations.getStock
        }
    }
}


struct Variations:Mappable {
    var variationId:String?
    var variationName:String?
    var stock:Int?
    var maximumOrderLimit:Int?
    var productDiscount:ProductDiscount?
    var price:Price?
    var isSelected:Bool? = false
    
    init?(map: Map) {
        
    }
    
    init(){}
    
    init(variationId:String?,variationName:String?,stock:Int?,maximumOrderLimit:Int?,price:Price?,productDiscount:ProductDiscount?){
        self.variationId = variationId
        self.variationName = variationName
        self.stock = stock
        self.maximumOrderLimit = maximumOrderLimit
        self.price = price
        self.productDiscount = productDiscount
    }
    
    mutating func mapping(map: Map) {
        variationId <- map["variationId"]
        variationName <- map["variationName"]
        stock <- map["stock"]
        productDiscount <- map["productDiscount"]
        maximumOrderLimit <- map["maximumOrderLimit"]
        price <- map["price"]
       
    }
}

extension Variations  {
    
    var getIsSelected:Bool {
        guard let isSelected = self.isSelected else {
            return false
        }
        return isSelected
    }
    
    var getProductDiscount:ProductDiscount {
        guard let productDiscount = self.productDiscount else {return ProductDiscount.init()}
        return productDiscount
    }
    
    var getPrice:Price {
        guard let price = self.price else {return Price.init()}
        return price
    }
    
    var getVariationId:String {
        guard let variationId = self.variationId else {return ""}
        return variationId
    }
   
    var getStock:Int {
        guard let stock = self.stock else {return 0}
        return stock
    }
    
    var getVariationName:String {
        guard let variationName = self.variationName  else {return ""}
        return variationName
    }
    
    var getMaximumOrderLimit:Int {
        guard let maximumOrderLimit = self.maximumOrderLimit else {return 0}
        return maximumOrderLimit
    }

}

struct ProductDiscount:Mappable {
    var flat:Any?
    var percentage:Any?
    
    init(){}
    
    init(flat:Int?,percentage:Int?) {
        self.flat = flat
        self.percentage = percentage
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        flat <- map["flat"]
        percentage <- map["percentage"]
    }
}

extension ProductDiscount {
    var getFlat:Int {
        guard let flat = self.flat else {return 0}
        
        if let flat = flat as? String {
            return Int(flat) ?? 0
        }else {
            return flat as? Int ?? 0
        }
        
    }
    
    var getPercentage:Int {
        guard let percentage = self.percentage else {return 0}
        
        if let percentage = percentage as? String {
            return Int(percentage) ?? 0
        }else {
            return percentage as? Int ?? 0
        }
    }
    
    var getDisCountType:String {
        if(getFlat > 0){
          return "Flat ৳\(getFlat) OFF"
        }else if(getPercentage > 0){
            return "\(getPercentage)% OFF"
        }else{
            return ""
        }
    }
}


struct Price:Mappable {
    var mrp:Any?
    var discountedPrice:Any?
    
    init?(map: Map) {
        
    }
    init(){}
    
    init( mrp:Double?,discountedPrice:Double?){
        self.mrp = mrp
        self.discountedPrice = discountedPrice
    }
    
    mutating func mapping(map: Map) {
        mrp <- map["mrp"]
        discountedPrice <- map["discountedPrice"]
    }
}

extension Price {
    var getMrp:Double {
        guard let mrp = self.mrp  else {
            return 0.0
        }
        if let mrp = mrp as? String {
            return Double(mrp) ?? 0.0
        }else {
            return mrp as? Double ?? 0.0
        }
       
    }
    
    var getDiscountedPrice:Double {
        guard let discountedPrice = self.discountedPrice else { return 0.0 }
        
        if let discountedPrice = discountedPrice as? String {
            return Double(discountedPrice) ?? 0.0
        }else {
            return discountedPrice as? Double ?? 0.0
        }
    }
    
    var getNewPrice:Double{
        if(getDiscountedPrice != 0.0 && getDiscountedPrice < getMrp) {
            return getDiscountedPrice
        }else {
            return getMrp
        }
    }
    
    var getOldPrice:Double {
        if(getDiscountedPrice != 0.0 && getDiscountedPrice < getMrp) {
            return getMrp
        }else {
            if(getDiscountedPrice == getMrp){
                return 0.0
            }else{
                return getDiscountedPrice
            }
        }
    }
}

struct AddOns:Mappable {
    var id:String?
    var name:String?
    var description:String?
    var numberOfRequired:Int?
    var items:[AddOnsItems]?
    init?(map: Map) {
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        numberOfRequired <- map["numberOfRequired"]
        items <- map["items"]
    }
    
    mutating func mapping(map: Map) {
        
    }
    
    var getName:String {
        guard let name = name else { return "" }
        return name
    }
    
    var getDescription:String {
        guard let description = description else {
            return ""
        }
        return description
    }
    
    var getNumberOfRequired:Int {
        guard let numberOfRequired = numberOfRequired else {
            return 0
        }
        return numberOfRequired
    }
    
    var getItems:[AddOnsItems] {
        guard let items = items else {
            return []
        }
        return items
    }
}



struct AddOnsItems:Mappable {
    var name:String?
    var amount:Any?
    var tp:Any?
    var isAddOnSelected:Bool? = false
    
    init?(map: Map) {
        
    }
    
    init(){}
    
    init(name:String?,amount:Any?,tp:Any?){
        self.name = name
        self.amount = amount
        self.tp = tp
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        amount <- map["amount"]
        tp <- map["tp"]
       
    }
}

extension AddOnsItems{
    
    var getAddOneName:String {
        guard let name = self.name  else {return ""}
        return name
    }
    
    var getAmount:Double {
        guard let amount = self.amount  else {
            return 0.0
        }
        if let amount = amount as? String {
            return Double(amount) ?? 0.0
        }else {
            return amount as? Double ?? 0.0
        }
    }
    
    var getTp:Double {
        guard let tp = self.tp  else {
            return 0.0
        }
        if let tp = tp as? String {
            return Double(tp) ?? 0.0
        }else {
            return tp as? Double ?? 0.0
        }
    }
    

    var getIsAddOnSelected:Bool {
        guard let isSelected = self.isAddOnSelected else {
            return false
        }
        return isSelected
    }

}


