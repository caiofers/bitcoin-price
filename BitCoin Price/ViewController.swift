//
//  ViewController.swift
//  BitCoin Price
//
//  Created by Caio Fernandes on 16/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    
    @IBAction func refreshPrice(_ sender: Any) {
        fetchPrice()
    }
    
    let numberFormatter = NumberFormatter()
    
    private var price: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPrice()
    }
    
    
    func fetchPrice() {
        if let url = URL(string: "https://blockchain.info/ticker") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    do {
                        let dataDecoded = try JSONDecoder().decode(Currency.self, from: data!)
                        if let buyPrice = self.formatNumberToBRLString(number: dataDecoded.currencyDetails.buy) {
                            self.priceLabel.text = buyPrice
                        }
                        
                    } catch { self.priceLabel.text = "Error" }
                } else {
                    self.priceLabel.text = "Error"
                }
            }
            task.resume()
        }
    }
    
    func formatNumberToBRLString(number: Double) -> String? {
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "pt_BR")
        if let price = self.numberFormatter.string(from: NSNumber(value: number)) {
            return price
        }
        return nil
    }
}

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
