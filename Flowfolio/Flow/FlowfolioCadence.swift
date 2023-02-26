//
//  FlowfolioCadence.swift
//  Flowfolio
//
//  Created by Yasir on 23/02/23.
//

import Foundation

class FlowfolioCadence {
    
    static let isAccountSetup = """
    import NonFungibleToken from 0xNONFUNGIBLETOKENADDRESS
    import Golazos from 0xGOLAZOSADDRESS
    
    pub fun main(address: Address): Bool {
        let account = getAccount(address)
        return account.getCapability<&{
                NonFungibleToken.CollectionPublic,
                Golazos.MomentNFTCollectionPublic
            }>(Golazos.CollectionPublicPath)
            != nil
    }
    """
    
    static let fetchAllEditions = """
    import Golazos from 0xGOLAZOSADDRESS
    
    pub fun main(): [Golazos.EditionData] {
        let editions: [Golazos.EditionData] = []
        var id: UInt64 = 1
        // Note < , as nextEditionID has not yet been used
        while id < Golazos.nextEditionID {
            editions.append(Golazos.getEditionData(id: id)!)
            id = id + 1
        }
        return editions
    }
    """
    
    static let fetchAllSeries = """
    import Golazos from 0xGOLAZOSADDRESS
    
    pub fun main(): [Golazos.SeriesData] {
        let series: [Golazos.SeriesData] = []
        var id: UInt64 = 1
        // Note < , as nextSeriesID has not yet been used
        while id < Golazos.nextSeriesID {
            series.append(Golazos.getSeriesData(id: id))
            id = id + 1
        }
        return series
    }
    """
    static let fetchAllPlays = """
    import Golazos from 0xGOLAZOSADDRESS
    
    pub fun main(): [Golazos.PlayData] {
        let plays: [Golazos.PlayData] = []
        var id: UInt64 = 1
        // Note < , as nextPlayID has not yet been used
        while id < Golazos.nextPlayID {
            plays.append(Golazos.getPlayData(id: id)!)
            id = id + 1
        }
        return plays
    }
    """
    
    static let fetchAllSets = """
    import Golazos from 0xGOLAZOSADDRESS
    
    pub fun main(): [Golazos.SetData] {
        let sets: [Golazos.SetData] = []
        var id: UInt64 = 1
        // Note < , as nextSetID has not yet been used
        while id < Golazos.nextSetID {
            sets.append(Golazos.getSetData(id: id)!)
            id = id + 1
        }
        return sets
    }
    """
    
    static let fetchAllSetNames = """
    import Golazos from 0xGOLAZOSADDRESS
    
    pub fun main(): [String] {
        return Golazos.getAllSetNames()
    }
    """
    
    static let fetchSetDataByName = """
    import Golazos from 0xGOLAZOSADDRESS
    
    pub fun main(setName: String): Golazos.SetData? {
        return Golazos.getSetDataByName(name: setName)
    }
    """
    
    static let fetchPlayDataById = """
    import Golazos from 0x87ca73a41bb50ad5
    
    pub fun main(playId: UInt64): {String: String}? {
    
        let playData = Golazos.getPlayData(id: playId)
    
        return playData?.metadata
    }
    """
}
