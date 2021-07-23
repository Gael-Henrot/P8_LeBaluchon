//
//  CurrencyViewController.swift
//  LeBaluchon
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
        
        currencyService.getCurrencyRate { (success, currencyData) in
            guard success else {
                self.presentAlert()
                return
            }
            if let currencyData = currencyData {
                self.rateLabel.text = "\(currencyData.rate)"
                self.rate = currencyData.rate
            } else {
                self.presentAlert()
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
    
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The currency rate download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        baseCurrencyTextField.resignFirstResponder()
    }
}
