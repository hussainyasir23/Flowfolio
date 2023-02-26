//
//  FlowManager.swift
//  Flowfolio
//
//  Created by Yasir on 23/02/23.
//

import Foundation
import FCL
import Flow

class FlowManager {
    
    static let shared = FlowManager()
    
    func setup() {
        
        let defaultProvider: FCL.Provider = .dapperSC
        let defaultNetwork: Flow.ChainID = .mainnet
        
        let accountProof = FCL.Metadata.AccountProofConfig(appIdentifier: "Flowfolio")
        let walletConnect = FCL.Metadata.WalletConnectConfig(urlScheme: "flowfolio://", projectID: "442fc676935a59f763d80b44037f7fb1")
        
        let metadata = FCL.Metadata(appName: "Flowfolio",
                                    appDescription: "The NFT portfolio app built using Flow",
                                    appIcon: URL(string: "https://raw.githubusercontent.com/hussainyasir23/Quick-Bite/main/Images/Cart%20Screen%201.png")!, //TODO - icon string to be placed
                                    location: URL(string: "https://monster-maker.vercel.app/")!, //TODO - web-url string to be placed
                                    accountProof: accountProof,
                                    walletConnectConfig: walletConnect)
        
        fcl.config(metadata: metadata,
                   env: defaultNetwork,
                   provider: defaultProvider)
        
        fcl.config
            .put("0xFungibleToken", value: "0xf233dcee88fe0abe")
            .put("0xNONFUNGIBLETOKENADDRESS", value: "0x1d7e57aa55817448")
            .put("0xGOLAZOSADDRESS", value: "0x87ca73a41bb50ad5")
            .put("0xMetadataViews", value: "0x631e88ae7f1d7c20")
            .put("0xTransactionGeneration", value: "0x44051d81c4720882")
    }
    
    func checkCollectionVault() async throws -> Bool {
        guard let address = fcl.currentUser?.addr else {
            throw FCLError.unauthenticated
        }
        
        do {
            let result: Bool = try await fcl.query(script: FlowfolioCadence.isAccountSetup, args: [.address(address)]).decode()
            return result
        } catch {
            print(error)
            throw error
        }
    }
    
    func fetchAllEditions() async throws -> [EditionData] {
        do {
            let result: [EditionData] = try await fcl.query(script: FlowfolioCadence.fetchAllEditions).decode()
            return result
        } catch {
            print(error)
            throw error
        }
    }
    
    func fetchAllSeries() async throws -> [SeriesData] {
        do {
            let result: [SeriesData] = try await fcl.query(script: FlowfolioCadence.fetchAllSeries).decode()
            return result
        } catch {
            print(error)
            throw(error)
        }
    }
    
    func fetchAllPlays() async throws -> [PlayData] {
        do {
            let rs = try await fcl.query(script: FlowfolioCadence.fetchAllPlays)
            let result: [PlayData] = try rs.decode()
            return result
        } catch {
            print(error)
            throw(error)
        }
    }
    
    func fetchAllSets() async throws -> [String] {
        do {
            let result: [String] = try await fcl.query(script: FlowfolioCadence.fetchAllSets).decode()
            return result
        } catch {
            print(error)
            throw(error)
        }
    }
    
    func fetchAllSetNames() async throws -> [String] {
        do {
            let result: [String] = try await fcl.query(script: FlowfolioCadence.fetchAllSetNames).decode()
            return result
        } catch {
            print(error)
            throw(error)
        }
    }
    
    func fetchSetDataByName(_ name: String) async throws -> String {
        do {
            let result: String = try await fcl.query(script: FlowfolioCadence.fetchSetDataByName, args: [.string(name)]).decode()
            return result
        } catch {
            print(error)
            throw error
        }
    }
    
    func fetchPlayDataById(_ id: Int) async throws -> [String:String]? {
        do {
            let result: [String:String]? = try await fcl.query(script: FlowfolioCadence.fetchPlayDataById, args: [.uint64(UInt64(id))]).decode()
            return result
        } catch {
            print(error)
            throw error
        }
    }
}
