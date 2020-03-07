//
//  ChordsService.swift
//  Chords
//
//  Created by Clément Martin on 05/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation

class ChordsService {
    
    private var task: URLSessionDataTask?
    static var shared = ChordsService()
    
    private var chordsSession = URLSession(configuration: .default)
    
    init(chordsSession: URLSession) {
        self.chordsSession = chordsSession
    }
    
    private init () {}
    
    func getChordsCurrent(completionHandler: @escaping(ChordsData?, NetworkError?) -> Void) {
        guard var request = ServiceCreateRequest.createRequest(url: Constant.chordsUrl) else { return }
        request.httpMethod = "GET"
        task?.cancel()
        task = chordsSession.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completionHandler(nil, NetworkError.badResponse)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(nil, NetworkError.badResponse)
                return
            }
            guard let chordsData = try? JSONDecoder().decode(ChordsData.self, from: data) else {
                
                completionHandler(nil, NetworkError.jsonDecodeFailed)
                return
            }
            completionHandler(chordsData, nil)
        }
        task?.resume()
    }
}
