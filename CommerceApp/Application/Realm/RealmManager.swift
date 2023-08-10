//
//  RealmManager.swift
//  CommerceApp
//
//  Created by Md Abdul Gafur on 11/8/23.
//
import Foundation
import RealmSwift

class RealmManager {
    
    public static func getProduct(product:Product,variation:Variations? = nil , updateValue:Int = 1 , addonsList:[AddOns] = []) -> ProductRealm {
        let productRealm = ProductRealm()
        
        productRealm.id = product.getId
        productRealm.name = product.getName
        productRealm.productImage = product.getProductImage
        if let variation = variation {
            productRealm.variation = getVariation(variant: variation)
        }
        productRealm.shopId = product.getShopId
        productRealm.shop = getShop(shop:product.getShop)
       
        productRealm.slug = product.getSlug
        productRealm.quantity = updateValue
        productRealm.isSelected = true
        productRealm.barCode = product.getBarCode
        productRealm.vat = product.shop?.getVat
        productRealm.sd = product.getIsSDApplicable
        
       
        return productRealm
    }
    
    public static func getVariation(variant:Variations) -> VariationRealm {
        let variationRealm = VariationRealm()
        variationRealm.variationId = variant.getVariationId
        variationRealm.variationName = variant.getVariationName
        variationRealm.stock = variant.getStock
        variationRealm.maximumOrderLimit = variant.getMaximumOrderLimit
        variationRealm.price = getPrice(price: variant.getPrice)
        return variationRealm
    }
    
    public static func getPrice(price:Price) -> PriceRealm {
        let priceRealm = PriceRealm()
        priceRealm.mrp = price.getMrp
        priceRealm.discountedPrice = price.getDiscountedPrice
        return priceRealm
    }
    
    
    public static func getShop(shop:Shop) -> ShopRealm {
        let shopRealm = ShopRealm()
        shopRealm.id = shop.getId
        shopRealm.name = shop.getName
        shopRealm.logo = shop.getLogo
        shopRealm.banner = shop.getBanner
        shopRealm.type = shop.getType
        shopRealm.isFreeDelivery = shop.getIsFreeDelivery
        shopRealm.baseDeliveryCharge = shop.getBaseDeliveryCharge
        shopRealm.vat = shop.getVat
        shopRealm.isSelected = true
        shopRealm.minimumAmountForFreeDelivery = shop.getMinimumAmountForFreeDelivery
        shopRealm.deliveryCharge = shop.getDeliveryCharge
        return shopRealm
    }
    
 
    
    
    public static func getSubTotal(productRealm:RealmSwift.Results<ProductRealm>) -> Double {
        var subTotal:Double = 0.0
        let selectedproduct = productRealm.where { $0.isSelected == true}
        for item in selectedproduct {
            subTotal = subTotal + ((item.getMrp) * Double(item.quantity))
        }
        return subTotal
    }
    
    public static func getDiscount(productRealm:RealmSwift.Results<ProductRealm>) -> Double {
        var discount:Double = 0.0
        let selectedproduct = productRealm.where { $0.isSelected == true}
        for item in selectedproduct {
            discount = discount + ((item.getMrp - item.getDiscountedPrice) * Double(item.quantity))
        }
        return discount
    }
    
    
    
    public static func getTotal(productRealm:RealmSwift.Results<ProductRealm>,promoDiscount:Double = 0.0) -> Double {
        let totalDiscount = getDiscount(productRealm: productRealm)
        return getSubTotal(productRealm: productRealm) - totalDiscount + getDeliveryCharge(productRealm: productRealm) - promoDiscount
    }
    
    public static func getCartTotal(productRealm:RealmSwift.Results<ProductRealm>,promoDiscount:Double = 0.0) -> Double {
      
        return getSubTotal(productRealm: productRealm) - getDiscount(productRealm: productRealm)
    }
    
    public static func getTotalP() -> Double {
        var total = 0.0
        do {
            let realm = try Realm()
            try realm.write {
                let productRealm = realm.objects(ProductRealm.self)
                total = getSubTotal(productRealm: productRealm) - getDiscount(productRealm: productRealm) + getDeliveryCharge(productRealm: productRealm)
            }
        }catch {print(error)}
        
        return total
    }
    
    public static func productCount() -> Int {
        var count  = 0
        do {
            let realm = try Realm()
            try realm.write {
                let baseProduct = realm.objects(ProductRealm.self).where {
                    $0.isSelected == true
                }
                count = baseProduct.count
            }
        }catch {print(error)}
        return count
    }
    
    
    public static func removeDelectedProduct() {
        do {
            let realm = try Realm()
            try realm.write {
                let productList = realm.objects(ProductRealm.self).where {
                    $0.isDelect == true
                }
                for product in productList {
                    
                    let baseProduct = realm.objects(ProductRealm.self).where {
                        $0.objectId == product.objectId
                    }
                    
                    if(baseProduct.count > 0){
                        if let variant = baseProduct[0].variation , let shop = baseProduct[0].shop {
                            realm.delete(realm.objects(PriceRealm.self).where { $0.objectId == variant.price!.objectId})
                            realm.delete(realm.objects(VariationRealm.self).where { $0.objectId == variant.objectId})
                            realm.delete(realm.objects(ShopRealm.self).where { $0.objectId == shop.objectId})
                            realm.delete(baseProduct)
                        }
                    }
                    
                }
            }
        }catch {print(error)}
    }
    
    public static func getDeliveryCharge(productRealm:RealmSwift.Results<ProductRealm>) -> Double {
        var deliveryCharge = 0.0
        let distinctShop  = getDistinct(productRealm: productRealm)
        
        for item in distinctShop {
            let shopSelectedProduct = productRealm.where {$0.shopId == item.getShopId && $0.isSelected == true}
            if(shopSelectedProduct.count > 0){
                if(item.getIsShopFreeDelivery){
                    deliveryCharge = deliveryCharge + 0.0
                }else if (item.getShopMinimumAmountForFreeDelivery > 0 && item.getShopMinimumAmountForFreeDelivery <= (getSubTotal(productRealm: productRealm) - getDiscount(productRealm: productRealm))){
                    deliveryCharge = deliveryCharge + 0.0
                }else{
                    deliveryCharge = deliveryCharge + item.getShopBaseDeliveryCharge
                }
            }else{
                deliveryCharge = deliveryCharge + 0.0
            }
            
        }
        return deliveryCharge
    }
    
    public static func RemoveProductById(objectId:ObjectId){
        do {
            let realm = try Realm()
            try realm.write() {
                let baseProduct = realm.objects(ProductRealm.self).where {
                    $0.objectId == objectId
                }
                
                if(baseProduct.count > 0){
                    if let variant = baseProduct[0].variation , let shop = baseProduct[0].shop  {
                        realm.delete(realm.objects(PriceRealm.self).where { $0.objectId == variant.price!.objectId})
                        realm.delete(realm.objects(VariationRealm.self).where { $0.objectId == variant.objectId})
                        realm.delete(realm.objects(ShopRealm.self).where { $0.objectId == shop.objectId})
                        realm.delete(baseProduct)
                    }
                }
                
            }
            
        }catch {print(error)}
    }
    
    public static func RemoveProductByProductId(id:String){
        do {
            let realm = try Realm()
            try realm.write() {
                let baseProduct = realm.objects(ProductRealm.self).where {
                    $0.id == id
                }
                
                if(baseProduct.count > 0){
                    if let variant = baseProduct[0].variation , let shop = baseProduct[0].shop  {
                        realm.delete(realm.objects(PriceRealm.self).where { $0.objectId == variant.price!.objectId})
                        realm.delete(realm.objects(VariationRealm.self).where { $0.objectId == variant.objectId})
                        realm.delete(realm.objects(ShopRealm.self).where { $0.objectId == shop.objectId})
                        
                        
                        realm.delete(baseProduct)
                    }
                }
                
            }
            
        }catch {print(error)}
    }
    
    public static func UpdateProductById(objectId:ObjectId){
        do {
            let realm = try Realm()
            
            try realm.write() {
                let baseProduct = realm.objects(ProductRealm.self).where {
                    $0.objectId == objectId
                }
                if(baseProduct.count > 0){
                    baseProduct[0].isDelect = true
                }
                
            }
            
        }catch {print(error)}
        
    }
    
    
    public static func RemoveProductRealm(complete:((Bool) -> Void)? = nil){
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(realm.objects(ProductRealm.self))
                realm.delete(realm.objects(VariationRealm.self))
                realm.delete(realm.objects(ShopRealm.self))
               
                realm.delete(realm.objects(ProductRealm.self))
              
                realm.delete(realm.objects(PriceRealm.self))
                if let complete = complete {
                    complete(true)
                }
            }
        }catch {print(error)}
    }
    
    
    public static func UpdateProduct(product:Product, variation:Variations , updateValue:Int = 0) {
        do {
            let realm = try Realm()
            let updateProduct = realm.objects(ProductRealm.self).first(where: { $0.id == product.getId && $0.variation?.variationId ==  variation.getVariationId })
            try realm.write {
                if let updateProduct = updateProduct {
                    if(updateValue > 0){
                        updateProduct.quantity = updateValue
                    }else{
                        updateProduct.quantity += 1
                    }
                    
                }
            }
        }catch {print(error)}
    }
    
    fileprivate func UpdateShop(realm:Realm,productRealm:ProductRealm,isSelected:Bool) {
        let updateProduct = realm.objects(ProductRealm.self).where {
            $0.shopId == productRealm.getShopId
        }
        for item in updateProduct {
            item.shop?.isSelected = isSelected
        }
    }
    
    public static func selectAllProduct(isSelected:Bool) {
        do {
            let realm = try Realm()
            let updateProduct = realm.objects(ProductRealm.self)
            try realm.write {
                for item in updateProduct {
                    item.shop?.isSelected = isSelected
                    item.isSelected = isSelected
                }
            }
            
        }catch {print(error)}
    }
    
    public static func selectionProduct(productRealm:ProductRealm? = nil, isProduct:Bool,isSelected:Bool? = nil) {
        do {
            let realm = try Realm()
            var updateProduct:RealmSwift.Results<ProductRealm>? = nil
            
            if(isProduct){
                updateProduct = realm.objects(ProductRealm.self).where {
                    $0.id == productRealm?.id ?? "" && $0.variation.variationId == productRealm?.getVariationId
                }
                
            }
            
            
            try realm.write {
                if let updateProduct = updateProduct {
                    for item in updateProduct {
                       
                            item.isSelected = isSelected
                        
                    }
                    if(isProduct){
                        if(realm.objects(ProductRealm.self).where { $0.shopId == productRealm?.getShopId}.count == realm.objects(ProductRealm.self).where{ $0.isSelected == true }.count ){
                            RealmManager().UpdateShop(realm:realm,productRealm:productRealm!,isSelected:true)
                        }else{
                            RealmManager().UpdateShop(realm:realm,productRealm:productRealm!,isSelected:false)
                        }
                    }
                    
                }
            }
        }catch {print(error)}
    }
    
    public static func UpdateProduct(productId:String, variationId:String , updateValue:Int = 0) {
        do {
            let realm = try Realm()
            let updateProduct = realm.objects(ProductRealm.self).first(where: { $0.id == productId && $0.variation?.variationId ==  variationId })
            try realm.write {
                if let updateProduct = updateProduct {
                    if(updateValue > 0){
                        updateProduct.quantity = updateValue
                    }else {
                        updateProduct.quantity += 1
                    }
                    
                }
            }
        }catch {print(error)}
    }
    
    public static func getDistinct(productRealm:RealmSwift.Results<ProductRealm>) -> RealmSwift.Results<ProductRealm> {
        if(productRealm.count > 0){
            return productRealm.distinct(by: ["shopId"])
        }else {
            return productRealm.distinct(by: ["shopId"])
        }
    }
    
    public static func getDistinctBySelection(productRealm:RealmSwift.Results<ProductRealm>) -> RealmSwift.Results<ProductRealm> {
        if(productRealm.count > 0){
            return productRealm.where{$0.isSelected == true}.distinct(by: ["shopId"])
        }else {
            return productRealm.where{$0.isSelected == true}.distinct(by: ["shopId"])
        }
    }
    
    public static func getProductCount(productRealm:RealmSwift.Results<ProductRealm>,product:Product, variation:Variations) -> Int {
        let productCheck = productRealm.filter("id == '\(product.getId)' AND variation.variationId == '\(variation.getVariationId)'")
        return productCheck.count > 0 ? productCheck[0].quantity : productCheck.count
    }
    
    public static func checkProduct(productRealm:RealmSwift.Results<ProductRealm>,product:Product, variation:Variations,complete:@escaping (Bool,Bool) -> Void ){
        
        let productCheck = productRealm.filter("id == '\(product.getId)' AND variation.variationId == '\(variation.getVariationId)'")
        
        
            if(productRealm.count > 0){
                if(productCheck.count > 0){
                    complete(false, true)
                }else{
                    complete(false, false)
                }
            }else{
                complete(false, false)
            }
        
    }
    
    public static func getProductType(productRealm:RealmSwift.Results<ProductRealm>)-> String {
        let productList = productRealm.where {$0.isSelected == true}
        if(productList.count > 0){
            return productList[0].shop?.type ?? ""
        }else{
            return ""
        }
        
    }
}
