//
//  ChordsData.swift
//  Chords
//
//  Created by Clément Martin on 05/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation

struct ChordsData: Codable {
    var allkeys: [AllKey]
    let allchords: [Allchord]?
   // let name: String?
    //let founded: Int?
   // let members: [String]?
}

struct Allchord: Codable {
    let midi: [Int]
    let suffix: String
    let fingers: [Int]
    let chordid: Int
}

struct AllKey: Codable {
    let keyid: Int
    let name: String
    let keychordids: [Int]
}
