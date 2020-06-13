//
//  ContentView.swift
//  Stock Calculator
//
//  Created by Daee Kang on 6/8/20.
//  Copyright © 2020 Daee Kang. All rights reserved.
//
import MovingNumbersView

import SwiftUI

struct ContentView: View {
    @ObservedObject var shareDetails = ShareDetail()
    

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack{
                    self.hexStringToUIColor(hex: "a8dadc")
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        HStack{
                            Button(action: {
                                self.hideKeyboard()
                                self.shareDetails.sharePrice = "0.00"
                                self.shareDetails.shareAmount = "0"
                                self.shareDetails.targetPrice = "0.00"
                                self.shareDetails.targetPriceSet = false
                            }){
                                Image(systemName: "gobackward")
                                    .foregroundColor(self.hexStringToUIColor(hex: "457B9D"))
                            }
                            .padding()
                            Spacer()
                        }
                        Spacer()
                    }
                    VStack{
                        //top
                        VStack{
                            Text("Profit (%xx)")
                                .foregroundColor(self.hexStringToUIColor(hex: "F1FAEE"))
                            HStack {
                                Text("$")
                                    .font(.system(size: 50))
                                    .foregroundColor(self.hexStringToUIColor(hex: "2a9d8f"))
                                MovingNumbersView(
                                    number: self.shareDetails.total,
                                    numberOfDecimalPlaces: 2) { str in
                                        // How to build each character
                                        Text(str)
                                            .font(.system(size: 50))
                                            .foregroundColor(self.hexStringToUIColor(hex: "2a9d8f"))
                                }
                            }
                            
                            HStack {
                                Text("Cash out: ")
                                    .font(.caption)
                                    .foregroundColor(Color.white)
                                Text("$")
                                    .foregroundColor(Color.white)
                                MovingNumbersView(number: self.shareDetails.cashOut, numberOfDecimalPlaces: 2) { str in
                                    Text(str)
                                        .foregroundColor(Color.white)
                                }
                            }
                            .padding(8)
                            .background(self.hexStringToUIColor(hex: "457B9D"))
                            .cornerRadius(10)
                            .padding(.top, 10)
                            
                        }
                        .padding(.top, 10)
                        
                        //bottom
                        VStack{
                            ZStack{
                                Color.white
                                    .edgesIgnoringSafeArea(.bottom)
                                VStack{
                                    HStack {
                                        Text("Cash in:   ")
                                            .font(.caption)
                                            .foregroundColor(Color.white)
                                        Text("$")
                                            .foregroundColor(Color.white)
                                        MovingNumbersView(number: self.shareDetails.cashIn, numberOfDecimalPlaces: 2) { str in
                                            Text(str)
                                                .foregroundColor(Color.white)
                                        }
                                    }
                                    .padding(8)
                                    .background(self.hexStringToUIColor(hex: "ee6c4d"))
                                    .cornerRadius(10)
                                    .padding(.top, 10)
                                    .padding(.bottom, 10)
                                    HStack{
                                        Spacer()
                                        VStack(alignment: .center){//cost per1 share
                                            TextField("5.00", text: self.$shareDetails.sharePrice, onEditingChanged: {(editingChanged) in
                                                if editingChanged {
                                                    //
                                                } else {
                                                    self.shareDetails.sharePrice = self.verifyAndFormatSharePrice(price: self.shareDetails.sharePrice)
                                                    if(!self.shareDetails.targetPriceSet) {
                                                        self.shareDetails.targetPrice = self.shareDetails.sharePrice
                                                    }
                                                }
                                            })
                                                .multilineTextAlignment(.center)
                                                .padding(10)
                                                .frame(width: geometry.size.width / 3)
                                                .background(Color.white)
                                                .border(Color.black)
                                                .keyboardType(.decimalPad)
                                                .foregroundColor(Color.black)
                                            Text("Cost per Share")
                                                .font(.caption)
                                                .foregroundColor(Color.gray)
                                        }
                                        Spacer()
                                        VStack(alignment: .center){// number of shares
                                            TextField("100", text: self.$shareDetails.shareAmount, onEditingChanged: {(editingChanged) in
                                                if editingChanged {
                                                    //
                                                } else {
                                                }
                                            })
                                                .multilineTextAlignment(.center)
                                                .padding(10)
                                                .frame(width: geometry.size.width / 3)
                                                .background(Color.white)
                                                .border(Color.black)
                                                .keyboardType(.numberPad)
                                                .foregroundColor(Color.black)
                                            Text("Number of Shares")
                                                .font(.caption)
                                                .foregroundColor(Color.gray)
                                        }
                                        Spacer()
                                    }

                                    Divider()
                                    //maybe search function here
                                    
                                    VStack{ //Target price
                                        TextField("10.00", text: self.$shareDetails.targetPrice, onEditingChanged: {(editingChanged) in
                                            if editingChanged {
                                                //
                                            } else {
                                                self.shareDetails.targetPriceSet = true
                                                self.shareDetails.targetPrice = self.verifyAndFormatSharePrice(price: self.shareDetails.targetPrice)
                                            }
                                        })
                                            .multilineTextAlignment(.center)
                                            .padding(10)
                                            .frame(width: geometry.size.width / 3)
                                            .background(Color.white)
                                            .border(Color.black)
                                            .padding(.top, 20)
                                            .keyboardType(.decimalPad)
                                            .foregroundColor(Color.black)
                                        Text("Target Price")
                                            .font(.caption)
                                            .foregroundColor(self.hexStringToUIColor(hex: "1d3557"))
                                    }
                                    Spacer()
                                }
                            }
                            
                        }
                    }
                }
                .onTapGesture {
                    self.hideKeyboard()
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
    
    func verifyAndFormatSharePrice(price: String) -> String {
        //find number of periods
        guard price.count > 0 else {
            return "0.00"
        }
        
        var numPeriods = 0
        for char in price {
            if char == "." {
                numPeriods += 1
            } else {
                guard Int(String(char)) != nil else {
                    return "0.00"
                }
            }
        }
        
        //debug
        print(numPeriods)
        
        if(numPeriods > 1) {
            //TO-DO: fix if there are multiple periods
        } else {
            //correct format god damn lmao
            return price
        }
        
        return price
    }
    
    func hexStringToUIColor (hex:String) -> Color {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return Color(UIColor.gray)
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return Color(UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        ))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
