//
//  PlayerData.swift
//  Flowfolio
//
//  Created by Yasir on 27/02/23.
//

import Foundation

struct PlayerData: Decodable {
    let id: Int
    let Link: String
    let Name: String
    let Tier: String
    let Image: String
    let Price: String
    let Total: String
    let Volume: String
    let MarketCap: String
}
