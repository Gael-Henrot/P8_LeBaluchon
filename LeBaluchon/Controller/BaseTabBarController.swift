//
//  BaseTabBarController.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 22/07/2021.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    @IBInspectable var defaultIndex: Int = 2

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex

        // Do any additional setup after loading the view.
    }
}
