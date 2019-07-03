//
//  ProfileScreenCoordinator.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import UIKit

protocol AuctionsScreenRouting {
    func buildDetailedAuctionScreen(auction: Auction) -> AuctionDetailsScreen
    func buildDetailedAuctionScreen(auction: Auction, action: @escaping (AuctionsScreenAction) -> Void) -> AuctionDetailsScreen
}

final class AuctionsScreenCoordinator: AuctionsScreenRouting {
    private let builders: AuctionsScreenChildBuilders
    private let network: APIFetchAuctionsProtocol
    
    init(builders b: AuctionsScreenChildBuilders, network n: APIFetchAuctionsProtocol) {
        builders = b
        network = n
    }
    
    func buildDetailedAuctionScreen(auction: Auction) -> AuctionDetailsScreen {
        return builders.makeDetailedWorkExperience(auction: auction)
    }
    
    func buildDetailedAuctionScreen(auction: Auction, action: @escaping (AuctionsScreenAction) -> Void) -> AuctionDetailsScreen {
        return builders.makeDetailedWorkExperience(auction: auction)
    }
}
