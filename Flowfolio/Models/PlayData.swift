//
//  PlayData.swift
//  Flowfolio
//
//  Created by Yasir on 26/02/23.
//

import Foundation

struct PlayData: Decodable {
    let id: Int
    let classification: String
    let metadata: [String: String]
    
    /// initializer
    //    init (id: UInt64) {
    //        let play = (&Golazos.playByID[id] as! &Golazos.Play?)!
    //        self.id = id
    //        self.classification = play.classification
    //        self.metadata = play.getMetadata()
    //    }
}


enum PlayMetaData: String {
    case PlayTime
    case PlayerFirstName
    case PlayerDataID
    case MatchHomeTeam
    case MatchAwayTeam
    case PlayerCountry
    case MatchAwayScore
    case PlayerPosition
    case PlayHalf
    case MatchSeason
    case MatchDate
    case MatchHighlightedTeam
    case MatchDay
    case PlayerKnownName
    case MatchHomeScore
    case PlayerNumber
    case PlayerJerseyName
    case PlayerLastName
    case PlayType
    case PlayDataID
}
