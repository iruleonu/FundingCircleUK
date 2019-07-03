//
//  AuctionsScreenViewModelTests.swift
//  ClearscoreTests
//
//  Created by Nuno Salvador on 23/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import XCTest
import Combine

@testable import FundingCircle

class AuctionsScreenViewModelTests: XCTestCase {
    var subject: AuctionsScreenViewModel!
    
    override func setUp() {
        super.setUp()
        let routing = AuctionsScreenRoutingMock()
        let network = NetworkMock()
        subject = AuctionsScreenViewModel(routing: routing, network: network)
    }
    
    override func tearDown() {
        super.tearDown()
        subject = nil
    }
    
    func testThatCallsFetchAuctionsOnDidAppear() {
        let expectation = self.expectation(description: "Calls fetch auctions on didAppear")
        
        _ = subject.didChange.sink { (vm) in
            expectation.fulfill()
        }
        subject.onAppear()
        
        waitForExpectations(timeout: TimeInterval(1)) { error in
            if error != nil {
                XCTFail()
            }
        }
    }
}

private class AuctionsScreenRoutingMock: AuctionsScreenRouting {
    func buildDetailedAuctionScreen(auction: Auction) -> AuctionDetailsScreen {
        return AuctionDetailsScreenBuilder().make(auction: auction)
    }
    
    func buildDetailedAuctionScreen(auction: Auction, action: @escaping (AuctionsScreenAction) -> Void) -> AuctionDetailsScreen {
        return AuctionDetailsScreenBuilder().make(auction: auction)
    }
}

private class NetworkMock: APIFetchAuctionsProtocol {
    func fetchAuctions() -> AnyPublisher<[Auction], APIServiceError> {
        return Publishers.Empty().eraseToAnyPublisher()
    }
}
