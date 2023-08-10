//
//  UniNeueTextView.swift
//  DhamakaShopping
//
//  Created by Invariant on 4/3/21.
//

import SwiftUI

struct UniNeueRegularTextView: View {
    @Environment(\.sizeCategory) var sizeCategory
    
    var text:String
    var fontSize:CGFloat
    var colorName:String
    var strikethrough:Bool = false
    
    var body:some View {
        Text(text).strikethrough(strikethrough, color: Color.gray).font(getDigitalXFontOfSize(size: fontSize)).foregroundColor(Color(colorName))
    }
    
    func getDigitalXFontOfSize(size s : CGFloat ) -> Font {
        if ( sizeCategory == .extraExtraExtraLarge || sizeCategory == .extraExtraLarge) {
            return Font.custom("UniNeueRegular", size: s - 20)
        }  else {
            return Font.custom("UniNeueRegular", size: s)
        }
    }
    
}

struct UniNeueRegularTextView_Previews: PreviewProvider {
    static var previews: some View {
        UniNeueRegularTextView(text: "For more details about this product, please dial 09610002345 to get, assist For more details about this product, please dial 09610002345 to get, assist", fontSize: 12, colorName: "000000")
    }
}
