//
//  CurrencyViewController.swift
//  Le-Baluchon
//
//  Created by Gaël HENROT on 19/07/2021.
//

import UIKit

class CurrencyViewController: UIViewController {

    @IBOutlet weak var baseCurrencyTextField: UITextField!
    @IBOutlet weak var targetCurrencyTextField: UITextField!
    @IBOutlet var rateLabel: UILabel!
    
    var rate: Double = 0.0
//    var baseCurrencyAmount: Double = 0.0
    
    @IBAction func tappedConvertButton() {
        convert()
    }
    let currencyService = CurrencyService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        currencyService.getCurrency { error, currencyData in
            guard error == nil else {
                // Afficher VC erreur
                return
            }
            if let currencyData = currencyData {
                self.rateLabel.text = "\(currencyData.rate)"
                self.rate = currencyData.rate
            } else {
                self.rateLabel.text = "0"
            }
            
        }
    }
   
    private func convert() {
        guard let baseCurrency = baseCurrencyTextField.text else {
            return
        }
        guard let baseCurrencyAmount = Double(baseCurrency) else {
            return
        }
        targetCurrencyTextField.text = "\(baseCurrencyAmount * rate)"
    }

}
