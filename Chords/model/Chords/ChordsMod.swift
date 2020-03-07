//
//  ChordsMod.swift
//  Chords
//
//  Created by Clément Martin on 05/03/2020.
//  Copyright © 2020 Clément Martin. All rights reserved.
//

import Foundation

class ChordsMod {
    
    var chordsStock: ChordsData?
    
    var dataSourceKeysName = [AllKey]()
    var dataourceChordsId = [Allchord]()
    var keyNameIdChord = [String:[Int]]()
    
    
    
    private var chordsServiceSession = ChordsService(chordsSession: URLSession(configuration: .default))
    init(chordsServiceSession: ChordsService) {
        self.chordsServiceSession = chordsServiceSession
    }
    
    func requestChords(completionHandler: @escaping(Bool?) -> Void) {
        chordsServiceSession.getChordsCurrent { [weak self] (chordsData, error) in
            guard let self = self else { return }
            guard error == nil else {
                completionHandler(false)
                return
            }
            guard let chordsData = chordsData else {
                completionHandler(false)
                return
            }
            print(chordsData)
            self.chordsStock = chordsData
            for key in self.chordsStock!.allkeys {
                self.dataSourceKeysName.append(key)
                //self.keyNameIdChord[key.name] = key.keychordids
            }
            completionHandler(true)
        }
    }
    
}
