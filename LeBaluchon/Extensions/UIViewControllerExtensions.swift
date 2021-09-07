//
//  AlertController.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 06/09/2021.
//

import UIKit

/// This extension allows the UIViewController to present a standard Alert Controller to warn the user when a problem occurrs.
extension UIViewController {
    func presentErrorAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
