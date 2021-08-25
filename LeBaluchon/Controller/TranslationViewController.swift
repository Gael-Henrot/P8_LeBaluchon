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
    }
    
    private func getTranslation() {
        translationService.getTranslation(textToTranslate: sourceLanguageTextView.text, callback: { (success, translationData) in
            guard success else {
                self.presentAlert()
                return
            }
            self.targetLanguageTextView.text = translationData?.translatedText
        })
    }
    
    /// This method presents a standard Alert Controller to warn the user when a problem occurrs during the translation update.
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The translation download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
