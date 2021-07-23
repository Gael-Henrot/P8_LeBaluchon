//
//  FakeCurrencyData.swift
//  LeBaluchonTests
//
//  Created by Gaël HENROT on 20/07/2021.
//

import Foundation

class FakeCurrencyData {
    static let responseOK = HTTPURLResponse(url: URL(string: "http://data.fixer.io/api/")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "http://data.fixer.io/api/")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
    
    class CurrencyError: Error {}
    static let error = CurrencyError()
    
    static var currencyCorrectData: Data {
        let bundle = Bundle(for: FakeCurrencyData.self)
        let url = bundle.url(forResource: "CurrencyData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var IncorrectCurrencyCorrectData: Data {
        let bundle = Bundle(for: FakeCurrencyData.self)
        let url = bundle.url(forResource: "IncorrectCurrencyData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let currencyIncorrectData = "erreur".data(using: .utf8)!
}
