//
//  CurrencyService.swift
//  Le-Baluchon
//
//  Created by Gaël HENROT on 19/07/2021.
//

import Foundation

class CurrencyService {
    
    private static let currencyUrl = "http://data.fixer.io/api/"
    
    private static let accessKey = "5cad2c4fc762e635763dce3fd6004590"
    let baseCurrency = "EUR"
    let targetCurrency = "USD"
    
    func getCurrency(callback: @escaping (CurrencyError?, CurrencyData?) -> Void) {
        
        let url = URL(string: "\(CurrencyService.currencyUrl)latest?access_key=\(CurrencyService.accessKey)&base=\(self.baseCurrency)&symbols=\(self.targetCurrency)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(.noData, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.incorrectResponse, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(CurrencyDataModel.self, from: data) else {
                    callback(.JSONTrouble, nil)
                    return
                }
                let base = responseJSON.base
                let date = responseJSON.date
                let target = self.targetCurrency
                guard let rate = responseJSON.rates[target] else {
                    return
                }
            
                let currencyData = CurrencyData(base: base, date: date, target: target, rate: rate)
                callback(nil, currencyData)
                }
            }
        task.resume()
    }
}

enum CurrencyError: Error {
    case noData, incorrectResponse, JSONTrouble
}
