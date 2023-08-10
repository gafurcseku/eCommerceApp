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
}

