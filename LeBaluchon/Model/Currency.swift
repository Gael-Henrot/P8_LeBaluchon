//
//  Currency.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 19/07/2021.
//

import Foundation

// Data model sent by the API.
struct CurrencyDataModel: Decodable {
    var base : String
    var date : String
    var rates = [String : Double]()
}

// Data model required by the application.
struct CurrencyData {
    var base : String
    var date : String
    var target : String
    var rate : Double
}

/*
 Response Data Model:
 
 {
    "success": true,
    "timestamp": 1626969004,
    "base": "EUR",
    "date": "2021-07-22",
    "rates": {
        "USD": 1.177045
    }
}*/
