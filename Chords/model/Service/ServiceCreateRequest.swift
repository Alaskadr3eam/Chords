//
//  ServiceCreateRequest.swift
//  Chords
//
//  Created by Clément Martin on 05/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation

struct ServiceCreateRequest {
   ///func for create request
    static func createRequest(url: URL) -> URLRequest? {
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let urlComplete = urlComponents?.url
        guard let urlSecure = urlComplete else { return nil }
        let request = URLRequest(url: urlSecure)
        return request
    }
}
