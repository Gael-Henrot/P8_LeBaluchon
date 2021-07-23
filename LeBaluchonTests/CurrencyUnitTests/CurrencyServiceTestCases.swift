//
//  CurrencyServiceTestCases.swift
//  LeBaluchonTests
//
//  Created by Gaël HENROT on 20/07/2021.
//

@testable import LeBaluchon
import XCTest

class CurrencyServiceTestCases: XCTestCase {
    func testGetCurrencyRateShouldPostFailedCallbackIfError() {
        let currencyService = CurrencyService(session: URLSessionFake(data: nil, response: nil, error: FakeCurrencyData.error))
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        currencyService.getCurrencyRate { (success, currencyData) in
            XCTAssertFalse(success)
            XCTAssertNil(currencyData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrencyRateShouldPostFailedCallbackIfNoData() {
        let currencyService = CurrencyService(session: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        currencyService.getCurrencyRate { (success, currencyData) in
            XCTAssertFalse(success)
            XCTAssertNil(currencyData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrencyRateShouldPostFailedCallbackIfIncorrectResponse() {
        let currencyService = CurrencyService(session: URLSessionFake(data: FakeCurrencyData.currencyCorrectData, response: FakeCurrencyData.responseKO, error: nil))
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        currencyService.getCurrencyRate { (success, currencyData) in
            XCTAssertFalse(success)
            XCTAssertNil(currencyData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrencyRateShouldPostFailedCallbackIfIncorrectData() {
        let currencyService = CurrencyService(session: URLSessionFake(data: FakeCurrencyData.currencyIncorrectData, response: FakeCurrencyData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        currencyService.getCurrencyRate { (success, currencyData) in
            XCTAssertFalse(success)
            XCTAssertNil(currencyData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrencyRateShouldPostFailedCallbackIfNoErrorAndIncorrectCurrency() {
        let currencyService = CurrencyService(session: URLSessionFake(data: FakeCurrencyData.IncorrectCurrencyCorrectData, response: FakeCurrencyData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        currencyService.getCurrencyRate { (success, currencyData) in
            XCTAssertFalse(success)
            XCTAssertNil(currencyData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetCurrencyRateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let currencyService = CurrencyService(session: URLSessionFake(data: FakeCurrencyData.currencyCorrectData, response: FakeCurrencyData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Waiting for queue change")
        currencyService.getCurrencyRate { (success, currencyData) in
            let target = "USD"
            let rate = 1.178919
            XCTAssertTrue(success)
            XCTAssertNotNil(currencyData)
            XCTAssertEqual(target, currencyData!.target)
            XCTAssertEqual(rate, currencyData!.rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
