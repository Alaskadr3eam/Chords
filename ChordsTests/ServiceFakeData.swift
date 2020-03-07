//
//  ServiceFakeData.swift
//  ChordsTests
//
//  Created by Clément Martin on 05/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation

class FakeResponseData {
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    // MARK: - Data
    static var chordsCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "ChordsJson", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static let chordsIncorrectData = "erreur".data(using: .utf8)!
    
    
}

class TestError: Error {
    static let error = TestError()
}


