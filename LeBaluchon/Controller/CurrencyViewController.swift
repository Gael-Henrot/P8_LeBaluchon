//
//  CurrencyViewController.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 19/07/2021.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    //MARK: - Properties:

    @IBOutlet weak var baseCurrencyTextField: UITextField!
    @IBOutlet weak var targetCurrencyTextField: UITextField!
    @IBOutlet var rateLabel: UILabel!
    
    var rate: Double = 0.0
    
    //MARK: - Methods
    
    @IBAction func tappedConvertButton() {
        convert()
    }
    
    let currencyService = CurrencyService()
    /// In the viewDidLoad(), the converting rate is updated and displays.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyService.getCurrencyRate { (success, currencyData) in
            guard success else {
                AlertController.presentErrorAlert(message: "The currency rate download failed.")
                return
            }
            if let currencyData = currencyData {
                self.rateLabel.text = "\(currencyData.rate)"
                self.rate = currencyData.rate
            } else {
                AlertController.presentErrorAlert(message: "The currency rate download failed.")
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
        targetCurrencyTextField.text = "\(round(100*(baseCurrencyAmount * rate))/100)"
    }
    
    /// This method hides the keyboard if the user touch outside the keyboard.
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        baseCurrencyTextField.resignFirstResponder()
    }
}
