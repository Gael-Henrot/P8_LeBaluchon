//
//  BaseTabBarController.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 22/07/2021.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    @IBInspectable var defaultIndex: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
    }
}

/// This extension allows to change the corner radius of every UIView in the storyboard.
public extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}
