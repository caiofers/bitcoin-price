//
//  ViewController.swift
//  BitCoin Price
//
//  Created by Caio Fernandes on 16/04/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBAction func refreshPrice(_ sender: Any) {
        fetchPrice()
    }
    
    let numberFormatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPrice()
    }
    
    func fetchPrice() {
        refreshButton.setTitle("Atualizando...", for: .normal)
        if let url = URL(string: "https://blockchain.info/ticker") {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    do {
                        let dataDecoded = try JSONDecoder().decode(Currency.self, from: data!)
                        let buyPrice = self.formatNumberToBRLString(number: dataDecoded.currencyDetails.buy)
                        DispatchQueue.main.async(execute: {
                            self.priceLabel.text = buyPrice
                            self.refreshButton.setTitle("Atualizar", for: .normal)
                        })
                    } catch {
                        DispatchQueue.main.async(execute: {
                            self.refreshButton.setTitle("Atualizar", for: .normal)
                        })
                    }
                } else {
                    DispatchQueue.main.async(execute: {
                        self.refreshButton.setTitle("Atualizar", for: .normal)
                    })
                }
            }
            task.resume()
        }
    }
    
    func formatNumberToBRLString(number: Double) -> String {
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "pt_BR")
        if let price = self.numberFormatter.string(from: NSNumber(value: number)) {
            return price
        }
        return self.numberFormatter.string(from: NSNumber(value: 0))!
    }
}
