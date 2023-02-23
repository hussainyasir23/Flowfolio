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
        let defaultNetwork: Flow.ChainID = .testnet
        
        let accountProof = FCL.Metadata.AccountProofConfig(appIdentifier: "Flowfolio")
        let walletConnect = FCL.Metadata.WalletConnectConfig(urlScheme: "flowfolio://", projectID: "442fc676935a59f763d80b44037f7fb1")
        
        let metadata = FCL.Metadata(appName: "Flowfolio",
                                    appDescription: "The NFT portfolio app built using Flow",
                                    appIcon: URL(string: "")!, //TODO - icon string to be placed
                                    location: URL(string: "")!, //TODO - web-url string to be placed
                                    accountProof: accountProof,
                                    walletConnectConfig: walletConnect)
        
        fcl.config(metadata: metadata,
                   env: defaultNetwork,
                   provider: defaultProvider)
        }
}
