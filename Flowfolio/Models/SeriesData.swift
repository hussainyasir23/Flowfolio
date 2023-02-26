//
//  SeriesData.swift
//  Flowfolio
//
//  Created by Yasir on 26/02/23.
//

import Foundation

struct SeriesData: Decodable {
    let id: Int
    let name: String
    let active: Bool
    
    /// initializer
    //        init (id: UInt64) {
    //            let series = (&Golazos.seriesByID[id] as! &Golazos.Series?)!
    //            self.id = series.id
    //            self.name = series.name
    //            self.active = series.active
    //        }
}
