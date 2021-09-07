//
//  FakeTranslationData.swift
//  LeBaluchonTests
//
//  Created by Gaël HENROT on 25/08/2021.
//

import Foundation

class FakeTranslationData {
    static let responseOK = HTTPURLResponse(url: URL(string: "https://www.google.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://www.google.com")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
    
    class TranslationError: Error {}
    static let error = TranslationError()
    
    static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeTranslationData.self)
        let url = bundle.url(forResource: "TranslationData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    static let translationIncorrectData = "erreur".data(using: .utf8)!
}
