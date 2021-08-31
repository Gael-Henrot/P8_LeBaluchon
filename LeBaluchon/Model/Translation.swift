//
//  Translation.swift
//  LeBaluchon
//
//  Created by Gaël HENROT on 30/07/2021.
//

import Foundation

// Data model sent by the API.
struct TranslationDataModel: Decodable {
    let data: DataElement
}

struct DataElement: Decodable {
    let translations: [TranslationsElement]
}

struct TranslationsElement: Decodable {
    let translatedText: String
}

// Data model required by the application.
struct TranslationData {
    let translatedText: String
}
/*
 Response Data Model:
 {
    "data": {
        "translations": [
            {
                "translatedText": "La Gran Pirámide de Giza (también conocida como la Pirámide de Keops o la Pirámide de Keops) es la más antigua y la más grande de las tres pirámides del complejo piramidal de Giza."
            }
        ]
    }
}*/
