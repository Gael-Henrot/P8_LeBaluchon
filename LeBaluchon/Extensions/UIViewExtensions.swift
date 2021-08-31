//
//  UIViewExtensions.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 31/08/2021.
//

import UIKit

/// This extension allows to change the corner radius of every UIView in the storyboard.
public extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
}
