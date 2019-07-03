//
//  WorkDetailsScreenBuilder.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import SwiftUI

// Actions available from childs built from PostsListChildBuilders
enum AuctionDetailsScreenAction {
    // Empty
}

protocol AuctionDetailsScreenChildBuilders {
    // Empty
}

struct AuctionDetailsScreenBuilder {
    func make(auction: Auction) -> AuctionDetailsScreen {
        let coordinator = AuctionDetailsCoordinator(builders: self)
        let vm = AuctionDetailsScreenViewModel(routing: coordinator, auction: auction)
        return AuctionDetailsScreen(viewModel: vm)
    }
}

extension AuctionDetailsScreenBuilder: AuctionDetailsScreenChildBuilders {
    
}
