//
//  JCProgeressUIView.swift
//  Jachai
//
//  Created by Gafur on 18/12/21.
//

import SwiftUI
import SSSwiftUIGIFView

struct JCProgeressUIView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                self.content()
                    .disabled(self.isShowing)
                    .background(Color("F8F8F8"))
                ZStack {
                    SwiftUIGIFPlayerView(gifName: "loading") .frame(width: 250,height: 250)
                    UrbanistMediumTextView(text: "Loading...", fontSize: 18, colorName: "191B32")
                }.opacity(self.isShowing ? 1 : 0)
                
            }
        }
        
    }
}

struct JCProgeressUIView_Previews: PreviewProvider {
    static var previews: some View {
        JCProgeressUIView(isShowing: .constant(true)){
            VStack{
                Text("...")
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
        }
    }
}

