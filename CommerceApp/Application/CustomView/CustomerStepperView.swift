//
//  CustomerStepperView.swift
//  CommerceApp
//
//  Created by Md Abdul Gafur on 10/8/23.
//

import SwiftUI


struct CustomerStepperView: View {
    @State var itemCount:Int = 0
    let minValue:Int
    let maxValue:Int
    var isDisable:Bool = false
    let callback: (Int)->()
    
    init(minValue:Int,maxValue:Int,defaultValue:Int = 0,isDisable:Bool = true,callback: @escaping (Int)->()){
        self.maxValue = maxValue
        self.minValue = minValue
        self.isDisable = isDisable
        self.callback = callback
        self._itemCount = State.init(initialValue: defaultValue)
    }
    
    var body: some View {
        HStack {
            Button(
                action: {
                    if(isDisable) {
                        if(self.itemCount > minValue){
                            self.itemCount -= 1
                            self.callback( self.itemCount)
                        }
                    }
                },
                label: {
                    Image(systemName: "minus")
                        .foregroundColor(Color("FFFFFF"))
                        .frame(width: 6, height: 6, alignment: .center)
                        .padding(15)
                        .background(Circle()
                            .fill(Color("000000")))
                        
                     
                }
            )
            
            UniNeueBoldTextView(text: "\(itemCount)", fontSize: 22, colorName: "3A494E")
                .padding([.leading,.trailing],10)
           
            Button(
                action: {
                    if(isDisable) {
                        if(self.itemCount < maxValue){
                            self.itemCount += 1
                            self.callback( self.itemCount)
                        }
                    }
                    
                },
                label: {
                    Image(systemName: "plus")
                        .foregroundColor(Color("FFFFFF"))
                        .frame(width: 6, height: 6, alignment: .center)
                        .padding(15)
                        .background(Circle()
                            .fill(Color("000000")))
                    
                }
            )
        }
        
    }
}

struct CustomerStepperView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerStepperView(minValue: 1,maxValue: 5,isDisable:false,callback: { itemCount in
           // print(itemCount)
        })
    }
}
