//
//  AlertController.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 06/09/2021.
//

import UIKit

/// This method presents a standard Alert Controller to warn the user when a problem occurrs.
class AlertController {
    static func presentErrorAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alertVC.present(alertVC, animated: true, completion: nil)
    }
}
