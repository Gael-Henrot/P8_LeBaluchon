//
//  WeatherServiceTestCases.swift
//  LeBaluchonTests
//
//  Created by Gaël HENROT on 23/07/2021.
//

@testable import LeBaluchon
import XCTest

class WeatherServiceTestCases: XCTestCase {
    func testGetWeatherShouldPostFailedCallbackIfError() {
        let weatherService = WeatherService(departureSession: URLSessionFake(data: nil, response: nil, error: FakeWeatherData.error),
                                            departurePictureSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            destinationSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            destinationPictureSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getDepartureWeather { (success, weatherData) in
            XCTAssertFalse(success)
            XCTAssertNil(weatherData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        let weatherService = WeatherService(departureSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            departurePictureSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            destinationSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            destinationPictureSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getDepartureWeather { (success, weatherData) in
            XCTAssertFalse(success)
            XCTAssertNil(weatherData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        let weatherService = WeatherService(departureSession: URLSessionFake(data: FakeWeatherData.weatherCorrectData, response: FakeWeatherData.responseKO, error: nil),
                                            departurePictureSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            destinationSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            destinationPictureSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getDepartureWeather { (success, weatherData) in
            XCTAssertFalse(success)
            XCTAssertNil(weatherData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        let weatherService = WeatherService(departureSession: URLSessionFake(data: FakeWeatherData.weatherIncorrectData, response: FakeWeatherData.responseOK, error: nil),
                                            departurePictureSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            destinationSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            destinationPictureSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getDepartureWeather { (success, weatherData) in
            XCTAssertFalse(success)
            XCTAssertNil(weatherData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetWeatherShouldPostFailedCallbackIfNoPictureData() {
        let weatherService = WeatherService(departureSession: URLSessionFake(data: FakeWeatherData.weatherCorrectData, response: FakeWeatherData.responseOK, error: nil),
                                            departurePictureSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            destinationSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            destinationPictureSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getDepartureWeather { (success, weatherData) in
            XCTAssertFalse(success)
            XCTAssertNil(weatherData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetWeatherShouldPostFailedCallbackIfErrorWhileRetrievingPicture() {
        let weatherService = WeatherService(departureSession: URLSessionFake(data: FakeWeatherData.weatherCorrectData, response: FakeWeatherData.responseOK, error: nil),
                                            departurePictureSession: URLSessionFake(data: FakeWeatherData.pictureData, response: FakeWeatherData.responseOK, error: FakeWeatherData.error),
                                            destinationSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            destinationPictureSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getDepartureWeather { (success, weatherData) in
            XCTAssertFalse(success)
            XCTAssertNil(weatherData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponseWhileRetrievingPicture() {
        let weatherService = WeatherService(departureSession: URLSessionFake(data: FakeWeatherData.weatherCorrectData, response: FakeWeatherData.responseOK, error: nil),
                                            departurePictureSession: URLSessionFake(data: FakeWeatherData.pictureData, response: FakeWeatherData.responseKO, error: nil),
                                            destinationSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            destinationPictureSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getDepartureWeather { (success, weatherData) in
            XCTAssertFalse(success)
            XCTAssertNil(weatherData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    /*func testGetDepartureWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let weatherService = WeatherService(departureSession: URLSessionFake(data: FakeWeatherData.weatherCorrectData, response: FakeWeatherData.responseOK, error: nil),
                                            departurePictureSession: URLSessionFake(data: FakeWeatherData.pictureData, response: FakeWeatherData.responseOK, error: nil),
                                            destinationSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            destinationPictureSession: URLSessionFake(data: nil, response: nil, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getDepartureWeather { (success, weatherData) in
            let description = "Ciel dégagé"
            let temperature = 19.9
            let picture = "picture".data(using: .utf8)
            XCTAssertTrue(success)
            XCTAssertNotNil(weatherData)
            XCTAssertEqual(description, weatherData?.description)
            XCTAssertEqual(temperature, weatherData?.temperature)
            XCTAssertEqual(picture, weatherData?.picture)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }*/
    func testGetDestinationWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let weatherService = WeatherService(departureSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            departurePictureSession: URLSessionFake(data: nil, response: nil, error: nil),
                                            destinationSession: URLSessionFake(data: FakeWeatherData.weatherCorrectData, response: FakeWeatherData.responseOK, error: nil),
                                            destinationPictureSession: URLSessionFake(data: FakeWeatherData.pictureData, response: FakeWeatherData.responseOK, error: nil))
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getDestinationWeather { (success, weatherData) in
            let description = "Ciel dégagé"
            let temperature = 19.9
            let picture = "picture".data(using: .utf8)
            XCTAssertTrue(success)
            XCTAssertNotNil(weatherData)
            XCTAssertEqual(description, weatherData?.description)
            XCTAssertEqual(temperature, weatherData?.temperature)
            XCTAssertEqual(picture, weatherData?.picture)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
