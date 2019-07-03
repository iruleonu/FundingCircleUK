//
//  AuctionResponse.swift
//  IRCV
//
//  Created by Nuno Salvador on 03/07/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation

struct AuctionsResponse: Codable {
    let items: [Auction]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}
