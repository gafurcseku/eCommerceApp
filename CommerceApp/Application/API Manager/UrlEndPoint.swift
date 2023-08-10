//
//  UrlEndPoint.swift
//  Jachai
//
//  Created by Gafur on 10/10/21.
//

import Foundation
import SwiftUI
// Default Image Url

let DemoImageUrl = "https://i.picsum.photos/id/292/3852/2556.jpg?hmac=cPYEh0I48Xpek2DPFLxTBhlZnKVhQCJsbprR-Awl9lo"
let BDT_SYMBOL_NO_Space = "৳"


// Production Url
let ProductBaseUrl = "https://staging-catalog-reader.qcoom.com/api/v1/"


enum ApiPath:String {
    case category_type = "category/type?isParent=true&type=Q_COMMERCE"
    case productsbyparentcategory = "product/products-by-parent-category?type=Q_COMMERCE"
    /////////////////////////////////////
    case banner = "banner?type="
   // case yourRestaurant = "shop/nearest"
    case category = "category/search?isParent=true&page=0&limit=200"
    case Product_Category = "product/product-category"
    case shop_category = "category/type?type=Q_MART&isParent=true"
    case hub_category = "hub/categories"
    case product_by_shop_category = "product/products-by-shop"
    case products_for_mart = "product/products-for-mart"
    case product_by_hub_category = "product/products-by-hub"
    case product_by_shop_and_category = "product/products-by-shop-and-category"
    case product_by_hub_and_category = "product/products-by-hub-and-category"
    case productDetails = "product/details"
    case address = "address"
    case allAddress = "address/all"
    case nearest = "shop/nearest"
    case nearestHub = "hub/nearest"
    case orderList = "order/my-orders/v2"
    case orderDetails = "order/details-by-user/v2"
    case order = "order"
    case send = "otp/send"
    case delete = "user/delete"
    case login = "user/login"
    case updateName = "user/update-name"
    case favorite = "favorite-product"
    case productsbyslugs = "product/products-by-slugs"
    case productsbyHubAndBarCodes = "product/products-by-hub-and-bar-codes"
    case popular = "search/popular"
    case shopSearch = "product/search-for-food"
    case grocerySearch = "product/search-for-grocery"
    case suggestion = "search/suggestion"
    case search = "product/search"
    case pay = "pay"
    case paymentMethod = "payment-method"
    case pushRegistration = "register"
    case geocode = "geocode"
    case autocomplete = "autocomplete"
    case biometric_register = "biometric/register"
    case biometric_login = "biometric/login"
    case promo = "promo"
    case promoValidate = "promo/v2"
    case parcel = "parcel"
    case parcelType = "parcel-type?isActive=true"
    case fare = "fare/parcel"
    case parcelDetails = "parcel/details"
    case myparcels = "parcel/my-parcels"
    case feedbackType = "feedback-type"
    case feedback = "feedback"
    case cancelOrder = "order/cancel-by-customer"
    case operatorType = "operator"
    case Topup_Customer = "topup/customer"
    case topup_history = "topup/history-for-customer"
    case brand = "brand"
    case bycampaign = "brand/by-campaign"
    case popular_products = "product/popular"
    case product = "product/v2"
   
    case categoriesByCampaign = "category/categories-by-campaign"
    case brandby_category = "brand/by-category"
    case shop = "shop"
    case childCategoryByBrand = "category/child-category-by-brand"
    case childCategoryByShop = "category/category-by-shop"
    case brand_by_shop = "brand/by-shop"
    case allCampaign = "campaign/all"
    case shopbycategory = "shop/by-category"
    case shopByCampaign = "shop/by-campaign"
    case neighborhood = "neighborhood"
    case campaign_wise_shop = "campaign/shop-wise"
    case user_details_v2 = "user/details/v2"
    case childCategoryByParent = "category/child-category-by-parent"
    case productByShopAndCategory = "product/all-products-by-shop-and-category"
   
    case deliveryCharge = "delivery-charge"
}

