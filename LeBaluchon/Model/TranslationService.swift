//
//  TranslationService.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 26/07/2021.
//

import Foundation

class TranslationService {
    
    //MARK: - Properties
    
    private static let APIKey = APIKeys.googleAPIKey
    
    private var task: URLSessionDataTask?
    
    private var translationSession: URLSession = URLSession(configuration: .default)
    
    var sourceLanguageCode: String = "fr"
    var targetLanguageCode: String = "en"
    
    //MARK: - Initializers
    
    init(translationSession: URLSession) {
        self.translationSession = translationSession
    }
    
    //MARK: - Methods
    func getTranslation(textToTranslate: String , callback: @escaping (Bool, TranslationData?) -> Void) {
        
        // URL creation
        var components = URLComponents()
        components.scheme = "https"
        components.host = "translation.googleapis.com"
        components.path = "/language/translate/v2"
        let queryItemAPIKey = URLQueryItem(name: "key", value: "\(TranslationService.APIKey)")
        let queryItemSourceText = URLQueryItem(name: "q", value: "\(textToTranslate)")
        let queryItemSourceCode = URLQueryItem(name: "source", value: "\(sourceLanguageCode)")
        let queryItemTargetText = URLQueryItem(name: "target", value: "\(targetLanguageCode)")
        components.queryItems = [queryItemAPIKey, queryItemSourceText, queryItemSourceCode, queryItemTargetText]
        // URL creation
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "POST"
        
        task?.cancel()
        task = translationSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(TranslationDataModel.self, from: data) else {
                    callback(false, nil)
                    return
                }
                let translation = TranslationData(translatedText: responseJSON.data.translations[0].translatedText)
                callback(true, translation)
                
            }
        }
        task?.resume()
    }
}
