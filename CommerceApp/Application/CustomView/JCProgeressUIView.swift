//
//  JCProgeressUIView.swift
//  Jachai
//
//  Created by Gafur on 18/12/21.
//

import SwiftUI


struct JCProgeressUIView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
      var content: () -> Content
      
      var body: some View {
          ZStack(alignment: .center) {
              self.content()
                  .disabled(self.isShowing)
                  .blur(radius: self.isShowing ? 3 : 0)
              
              ProgressView()
                  .progressViewStyle(.circular)
                  .frame(width: 100,height: 100)
                  .background(Color.secondary.colorInvert())
                  .foregroundColor(Color.primary)
                  .cornerRadius(20)
                  .opacity(self.isShowing ? 1 : 0)
              
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

