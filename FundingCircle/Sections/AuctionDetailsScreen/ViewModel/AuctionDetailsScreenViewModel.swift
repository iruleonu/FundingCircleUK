//
//  AuctionDetailsScreenViewModel.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class AuctionDetailsScreenViewModel: BindableObject {
    private(set) var routing: AuctionDetailsRouting
    
    private(set) var auction: Auction {
        didSet {
            updatePropertiesFromAuction(auction)
            didChange.send(self)
        }
    }
    
    var didChange = PassthroughSubject<AuctionDetailsScreenViewModel, Never>()
    
    /// Bindings
    var title: String = ""
    var rate: Float = 0.0
    var amountCents: Int = 0
    var term: Int = 0
    var riskBand: String = ""
    var closeTime: String = ""
    var estimatedReturnAmount: String = ""
    
    init(routing: AuctionDetailsRouting, auction: Auction) {
        self.routing = routing
        self.auction = auction
    }
    
    func onAppear() {
        // didSet arent called on init
        updatePropertiesFromAuction(auction)
    }
    
    private func updatePropertiesFromAuction(_ auction: Auction) {
        title = auction.title
        rate = auction.rate
        amountCents = auction.amountCents
        term = auction.term
        riskBand = auction.riskBand
        closeTime = auction.closeTime.description
        estimatedReturnAmount = "\(auction.era())"
    }
}
