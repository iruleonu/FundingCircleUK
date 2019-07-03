//
//  Auction.swift
//  IRCV
//
//  Created by Nuno Salvador on 03/07/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import SwiftUI

struct Auction: Codable, Identifiable {
    let id: Int
    let title: String
    let rate: Float
    let amountCents: Int
    let term: Int
    let riskBand: String
    let closeTime: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case rate
        case amountCents = "amount_cents"
        case term
        case riskBand = "risk_band"
        case closeTime = "close_time"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let title = try container.decode(String.self, forKey: .title)
        let rate = try container.decode(Float.self, forKey: .rate)
        let amountCents = try container.decode(Int.self, forKey: .amountCents)
        let term = try container.decode(Int.self, forKey: .term)
        let riskBand = try container.decode(String.self, forKey: .riskBand)
        let closeTime = try container.decode(Date.self, forKey: .closeTime)
        self.init(id: id, title: title, rate: rate, amountCents: amountCents, term: term, riskBand: riskBand, closeTime: closeTime)
    }
    
    init(id: Int, title: String, rate: Float, amountCents: Int, term: Int, riskBand: String, closeTime: Date) {
        self.id = id
        self.title = title
        self.rate = rate
        self.amountCents = amountCents
        self.term = term
        self.riskBand = riskBand
        self.closeTime = closeTime
    }
}

extension Auction: Equatable {
    static func == (left: Auction, right: Auction) -> Bool {
        return left.id == right.id
    }
}
