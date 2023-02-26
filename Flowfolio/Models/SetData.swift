//
//  SetData.swift
//  Flowfolio
//
//  Created by Yasir on 26/02/23.
//

import Foundation

struct SetData: Decodable {
    let id: Int
    let name: String
    let locked: Bool
    var setPlaysInEditions: [Int:Bool]

    /// member function to check the setPlaysInEditions to see if this Set/Play combination already exists
    func setPlayExistsInEdition(playID: Int) -> Bool {
        return self.setPlaysInEditions.contains(where: {$0.key == playID})
    }

    /// initializer
    //        init (id: UInt64) {
    //            let set = (&Golazos.setByID[id] as! &Golazos.Set?)!
    //            self.id = id
    //            self.name = set.name
    //            self.locked = set.locked
    //            self.setPlaysInEditions = set.getSetPlaysInEditions()
    //        }
}
