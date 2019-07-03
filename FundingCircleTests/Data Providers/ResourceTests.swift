//
//  ResourceTests.swift
//  IRShowcaseTests
//
//  Created by Nuno Salvador on 02/04/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import XCTest

@testable import FundingCircle

class ResourceTests: XCTestCase {
    
    func testEqualityForSameResource() {
        let resource1 = Resource.auctions
        let resource2 = Resource.auctions
        XCTAssertEqual(resource1, resource2)
        
        let resource3 = Resource.unknown
        let resource4 = Resource.unknown
        XCTAssertEqual(resource3, resource4)
    }
    
    func testInequalityForDifferentResource() {
        let resource1 = Resource.auctions
        let resource2 = Resource.unknown
        XCTAssertNotEqual(resource1, resource2)
        XCTAssertNotEqual(resource2, resource1)
    }
}
