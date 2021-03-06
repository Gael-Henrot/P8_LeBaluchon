//
//  CurrencyService.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 19/07/2021.
//

import Foundation

class CurrencyService {
    
    //MARK: - Properties
    private static let currencyUrl = "http://data.fixer.io/api/"
    
    private static let accessKey = APIKeys.dataFixerIOAPIKey
    let baseCurrency = "EUR"
    let targetCurrency = "USD"
    
    private var session: URLSession
    
    //MARK: - Initializers
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    //MARK: - Methods
    /// This method provides the rate between the base currency and the target currency from the data.fixer.io API.
    func getCurrencyRate(callback: @escaping (Bool, CurrencyData?) -> Void) {
        
        let url = URL(string: "\(CurrencyService.currencyUrl)latest?access_key=\(CurrencyService.accessKey)&base=\(self.baseCurrency)&symbols=\(self.targetCurrency)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(CurrencyDataModel.self, from: data) else {
                    callback(false, nil)
                    return
                }
                let base = responseJSON.base
                let date = responseJSON.date
                let target = self.targetCurrency
                guard let rate = responseJSON.rates[target] else {
                    callback(false, nil)
                    return
                }
            
                let currencyData = CurrencyData(base: base, date: date, target: target, rate: rate)
                callback(true, currencyData)
                }
            }
        task.resume()
    }
}
