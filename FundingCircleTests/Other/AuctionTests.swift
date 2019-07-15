//
//  AuctionTests.swift
//  FundingCircleTests
//
//  Created by Nuno Salvador on 16/07/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import XCTest
import Combine

@testable import FundingCircle

class AuctionTests: XCTestCase {
    var subject: [Auction]!
    
    override func setUp() {
        super.setUp()
        let auctionResponse: AuctionsResponse = Factory.object(from: "auctions", extension: "json")
        subject = auctionResponse.items
    }
    
    override func tearDown() {
        super.tearDown()
        subject = nil
    }
    
    func testExpectedEraWithDefaultFee() {
        let eraOne = subject[0].era()
        let expectedOne = "10700.00003799796099072"
        XCTAssert(eraOne.description == expectedOne)
        let eraTwo = subject[1].era()
        let expectedTwo = "110999.9995455145828352"
        XCTAssert(eraTwo.description == expectedTwo)
        let eraThree = subject[2].era()
        let expectedThree = "58199.99998658895501312"
        XCTAssert(eraThree.description == expectedThree)
    }
    
    func testExpectedEraWithRandomFee() {
        let eraOne = subject[0].era(fee: 100)
        let expectedOne = "-989199.999964237213184"
        XCTAssert(eraOne.description == expectedOne)
        let eraTwo = subject[1].era(fee: 100)
        let expectedTwo = "-9888000.000476837158912"
        XCTAssert(eraTwo.description == expectedTwo)
    }
    
    func testUnknownRiskBandToHaveNilEstimatedBadDebt() {
        let era = Auction(id: 0, title: "", rate: 0, amountCents: 0, term: 0, riskBand: "Z", closeTime: Date())
        XCTAssert(era.riskBandEnum.estimatedBadDebt.isEqual(to: Decimal.zero))
    }
}
