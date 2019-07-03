//
//  ProfileScreenBuilder.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import SwiftUI

// Actions available from childs built from PostsListChildBuilders
enum AuctionsScreenAction {
    // Empty
}

protocol AuctionsScreenChildBuilders {
    func makeDetailedWorkExperience(auction: Auction) -> AuctionDetailsScreen
}

struct AuctionsScreenBuilder {
    func make(network: APIFetchAuctionsProtocol) -> AuctionsScreenView {
        let coordinator = AuctionsScreenCoordinator(builders: self, network: network)
        let vm = AuctionsScreenViewModel(routing: coordinator, network: network)
        return AuctionsScreenView(viewModel: vm)
    }
}

extension AuctionsScreenBuilder: AuctionsScreenChildBuilders {
    func makeDetailedWorkExperience(auction: Auction) -> AuctionDetailsScreen {
        return AuctionDetailsScreenBuilder().make(auction: auction)
    }
}
