//
//  ShareDetails.swift
//  Stock Calculator
//
//  Created by Daee Kang on 6/12/20.
//  Copyright © 2020 Daee Kang. All rights reserved.
//

import Foundation

class ShareDetail: ObservableObject {
    init(){
        
    }
    
    @Published var sharePrice = "" {
        didSet {
            sharePriceNum = Double(sharePrice) ?? 0
            updateTotals()
        }
    }
    @Published var shareAmount = "" {
        didSet {
            shareAmountNum = Int(shareAmount) ?? 0
            updateTotals()
        }
    }
    @Published var targetPrice = "" {
        didSet {
            targetPriceNum = Double(targetPrice) ?? 0
            updateTotals()
        }
    }
    
    @Published var targetPriceSet = false
    
    @Published var sharePriceNum: Double = 0
    @Published var shareAmountNum: Int = 0
    @Published var targetPriceNum: Double = 0
    @Published var total: Double = 0
    
    @Published var cashIn: Double = 0
    @Published var cashOut: Double = 0
    
    func updateTotals() {
        let targetStock: Double = targetPriceNum * Double(shareAmountNum)
        let originalStock: Double = sharePriceNum * Double(shareAmountNum)
        total = targetStock - originalStock
        
        cashIn = sharePriceNum * Double(shareAmountNum)
        cashOut = cashIn + total
    }
}
