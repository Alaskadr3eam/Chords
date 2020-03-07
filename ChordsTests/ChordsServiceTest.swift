//
//  ChordsServiceTest.swift
//  ChordsTests
//
//  Created by Clément Martin on 05/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import XCTest
@testable import Chords

class ChordsServiceTest: XCTestCase {

    func testGetChordsShouldPostFailedCallbackIfError() {
        //Given
        let chordsService = ChordsService(chordsSession: URLSessionFake(data: nil, response: nil, error: TestError.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        chordsService.getChordsCurrent { (chordsData, error) in
            // Then
            XCTAssertEqual(error, NetworkError.badResponse)
            XCTAssertNil(chordsData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetChordsShouldPostFailedCallbackIfNoData() {
        // Given
        let chordsService = ChordsService(
            chordsSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        chordsService.getChordsCurrent { (chordsData,error) in
            // Then
            XCTAssertEqual(error, NetworkError.badResponse)
            XCTAssertNil(chordsData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetChordsShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let chordsService = ChordsService(
        chordsSession: URLSessionFake(data: FakeResponseData.chordsCorrectData,response: FakeResponseData.responseKO,error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        chordsService.getChordsCurrent{ (chordsData,error) in
            // Then
            XCTAssertEqual(error,NetworkError.badResponse)
            XCTAssertNil(chordsData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetChordsShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let chordsService = ChordsService(
        chordsSession: URLSessionFake(data: FakeResponseData.chordsIncorrectData,response: FakeResponseData.responseOK,error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        chordsService.getChordsCurrent { (chordsData,error) in
            // Then
            XCTAssertEqual(error, NetworkError.jsonDecodeFailed)
            XCTAssertNil(chordsData)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetChordsShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let chordsService = ChordsService(
        chordsSession: URLSessionFake(data: FakeResponseData.chordsCorrectData,response: FakeResponseData.responseOK,error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change")
        chordsService.getChordsCurrent { (chordsData,error) in
            
            XCTAssertNil(error)
            XCTAssertEqual(chordsData?.allkeys[0].name, "C")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }


}
