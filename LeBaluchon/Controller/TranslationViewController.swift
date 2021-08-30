//
//  TranslationViewController.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 21/07/2021.
//

import UIKit

class TranslationViewController: UIViewController {
    //MARK: - Properties:

    @IBOutlet weak var sourceLanguageTextView: UITextView!
    @IBOutlet weak var targetLanguageTextView: UITextView!
    @IBOutlet weak var sourceLanguageLabel: UILabel!
    @IBOutlet weak var targetLanguageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sourceLanguageLabel.text = "Français"
        targetLanguageLabel.text = "Anglais"
    }
    
    var textToTranslate: String?
    var targetLanguageCode: String?
    
    let translationService = TranslationService(translationSession: URLSession(configuration: .default))
    //MARK: - Methods
    @IBAction func tappedTranslationButton() {
        getTranslation()
        sourceLanguageTextView.resignFirstResponder()
    }
    
    /// This method call the model getTranslation method and display the result.
    private func getTranslation() {
        translationService.getTranslation(textToTranslate: sourceLanguageTextView.text, callback: { (success, translationData) in
            guard success else {
                self.presentAlert()
                return
            }
            self.targetLanguageTextView.text = translationData?.translatedText
        })
    }
    
    /// This method reverses the source langage and the target language (all labels, text views and getTranlation method).
    @IBAction func tappedInversionButton() {
        swap(&translationService.sourceLanguageCode, &translationService.targetLanguageCode)
        swap(&(sourceLanguageLabel.text)!, &(targetLanguageLabel.text)!)
        swap(&sourceLanguageTextView.text, &targetLanguageTextView.text)
    }
    
    /// This method swap the value (String) of two variables.
    private func swap( _ a: inout String, _ b: inout String) {
        (a, b) = (b, a)
    }
    
    /// This method presents a standard Alert Controller to warn the user when a problem occurrs during the translation update.
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The translation download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    /// This method hides the keyboard if the user touch outside the keyboard.
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        sourceLanguageTextView.resignFirstResponder()
    }
}
