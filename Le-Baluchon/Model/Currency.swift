//
//  Currency.swift
//  Le-Baluchon
//
//  Created by Gaël HENROT on 19/07/2021.
//

import Foundation

struct CurrencyDataModel: Decodable {
    var base : String
    var date : String
    var rates = [String : Double]()
}

struct CurrencyData {
    var base : String
    var date : String
    var target : String
    var rate : Double
}
