//
//  Constant.swift
//  Chords
//
//  Created by Clément Martin on 05/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    //MARK: - URL
    static let chordsUrl = URL(string:"https://europe-west1-mwm-sandbox.cloudfunctions.net/midi-chords")!
    //MARK: - Rotztion Transform for pickerView
    static let rotation: CGFloat = -90 * (.pi/180)
}
