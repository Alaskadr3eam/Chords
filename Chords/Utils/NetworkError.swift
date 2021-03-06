//
//  NetworkError.swift
//  Chords
//
//  Created by Clément Martin on 05/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation
import UIKit

/// Give information on the error encountered in a request
enum NetworkError: String {
    /// The request URL could not be generate
    case invalidRequestURL = "Invalid data provider"
    
    /// The API returned an error
    case errorFromAPI = "The request returned an error"
    
    /// The request returned an bad response
    case badResponse = "The request returned a bad response"
    
    /// Data are empty
    case emptyData = "No data found"
    
    /// Json decoding failed
    case jsonDecodeFailed = "Unexpected data"
    
    static func getAlert(_ error: NetworkError) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(confirmAction)
        return alert
    }
}
