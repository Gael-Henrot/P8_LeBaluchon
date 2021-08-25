//
//  TranslationServiceTestCases.swift
//  LeBaluchonTests
//
//  Created by Gaël HENROT on 25/08/2021.
//

@testable import LeBaluchon
import XCTest

class TranslationServiceTestCases: XCTestCase {
    func testGetTranslationShouldPostFailedCallbackIfError() {
        let translationService = TranslationService(translationSession: URLSessionFake(data: nil, response: nil, error: FakeTranslationData.error))
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        translationService.getTranslation(textToTranslate: "texte", callback: { (success, translationData) in
            XCTAssertFalse(success)
            XCTAssertNil(translationData)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        let translationService = TranslationService(translationSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        translationService.getTranslation(textToTranslate: "texte", callback: { (success, translationData) in
            XCTAssertFalse(success)
            XCTAssertNil(translationData)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        let translationService = TranslationService(translationSession: URLSessionFake(data: FakeTranslationData.translationCorrectData, response: FakeTranslationData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        translationService.getTranslation(textToTranslate: "texte", callback: { (success, translationData) in
            XCTAssertFalse(success)
            XCTAssertNil(translationData)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        let translationService = TranslationService(translationSession: URLSessionFake(data: FakeTranslationData.translationIncorrectData, response: FakeTranslationData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        translationService.getTranslation(textToTranslate: "texte", callback: { (success, translationData) in
            XCTAssertFalse(success)
            XCTAssertNil(translationData)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let translationService = TranslationService(translationSession: URLSessionFake(data: FakeTranslationData.translationCorrectData, response: FakeTranslationData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        translationService.getTranslation(textToTranslate: "Text to translate", callback: { (success, translationData) in
            let translatedText = "Texte à traduire"
            XCTAssertTrue(success)
            XCTAssertNotNil(translationData)
            XCTAssertEqual(translatedText, translationData!.translatedText)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.01)
    }
    
}
