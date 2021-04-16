//
//  Currency.swift
//  BitCoin Price
//
//  Created by Caio Fernandes on 16/04/21.
//

import Foundation

struct Currency: Decodable {
    var currencyDetails: CurrencyDetails

    init (currencyDetails: CurrencyDetails){
        self.currencyDetails = currencyDetails
    }
    
    enum CodingKeys: String, CodingKey {
       case currencyDetails = "BRL"
    }
}

struct CurrencyDetails: Decodable {
    var fifthteenMin: Double
    var last: Double
    var buy: Double
    var sell: Double
    var symbol: String
    
    init(fifthteenMin: Double, last: Double, buy: Double, sell: Double, symbol: String) {
        self.fifthteenMin = fifthteenMin
        self.last = last
        self.buy = buy
        self.sell = sell
        self.symbol = symbol
    }
    
    enum CodingKeys: String, CodingKey {
       case fifthteenMin = "15m", last, buy, sell, symbol
    }
}
