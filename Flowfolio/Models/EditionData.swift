//
//  EditionData.swift
//  Flowfolio
//
//  Created by Yasir on 26/02/23.
//

import Foundation

struct EditionData: Decodable {
    let id: Int
    let seriesID: Int
    let setID: Int
    let playID: Int
    var maxMintSize: Int?
    let tier: String
    var numMinted: Int
    
    /// member function to check if max edition size has been reached
    func maxEditionMintSizeReached() -> Bool {
        return self.numMinted == self.maxMintSize
    }
    
    /// initializer
    //        init (id: UInt64) {
    //            let edition = (&Golazos.editionByID[id] as! &Golazos.Edition?)!
    //            self.id = id
    //            self.seriesID = edition.seriesID
    //            self.playID = edition.playID
    //            self.setID = edition.setID
    //            self.maxMintSize = edition.maxMintSize
    //            self.tier = edition.tier
    //            self.numMinted = edition.numMinted
    //        }
}

enum EditionTier: String {
    case COMMON
    case RARE
    case LEGENDARY
    case UNCOMMON
}
