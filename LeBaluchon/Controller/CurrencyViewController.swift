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
    /// In the viewDidLoad(), the converting rate is updated and displays.
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
   
    /// This method retrieves the amount to convert and applies the rate to its.
    private func convert() {
        guard let baseCurrency = baseCurrencyTextField.text else {
            return
        }
        guard let baseCurrencyAmount = Double(baseCurrency) else {
            return
        }
        targetCurrencyTextField.text = "\(baseCurrencyAmount * rate)"
    }
    
    /// This method presents a standard Alert Controller to warn the user when a problem occurrs during the rate update.
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The currency rate download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    /// This method hides the keyboard if the user touch outside the keyboard.
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        baseCurrencyTextField.resignFirstResponder()
    }
}
