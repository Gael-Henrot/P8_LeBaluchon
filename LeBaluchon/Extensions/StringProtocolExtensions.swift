//
//  StringProtocolExtensions.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 01/09/2021.
//

import Foundation

extension StringProtocol {
    /// This parameter modifies the initial variable by uppercasing the first letter of its.
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
}
