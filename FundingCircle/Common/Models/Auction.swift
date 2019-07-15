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
    enum RiskBandTable: String {
        case unknown = "unknown"
        case APlus = "A+"
        case A = "A"
        case B = "B"
        case C = "C"
        case CMinus = "C-"
        
        var estimatedBadDebt: Decimal {
            switch self {
            case .APlus:
                return 0.01
            case .A:
                return 0.02
            case .B:
                return 0.03
            case .C:
                return 0.04
            case .CMinus:
                return 0.05
            default:
                return 0.00
            }
        }
        
        init(riskBand: String) {
            switch riskBand {
            case RiskBandTable.APlus.rawValue:
                self = RiskBandTable.APlus
            case RiskBandTable.A.rawValue:
                self = RiskBandTable.A
            case RiskBandTable.B.rawValue:
                self = RiskBandTable.B
            case RiskBandTable.C.rawValue:
                self = RiskBandTable.C
            case RiskBandTable.CMinus.rawValue:
                self = RiskBandTable.CMinus
            default:
                self = RiskBandTable.unknown
            }
        }
    }
    
    let id: Int
    let title: String
    let rate: Float
    let amountCents: Int
    let term: Int
    let riskBand: String
    let riskBandEnum: RiskBandTable
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
        self.riskBandEnum = RiskBandTable(riskBand: riskBand)
    }
}

extension Auction: Equatable {
    static func == (left: Auction, right: Auction) -> Bool {
        return left.id == right.id
    }
}

extension Auction {
    /// era = (1 + ar − ebd − f) x ba
    /// where:
    /// ● era is the estimated return amount in GBP.
    /// ● ar is the auction's rate.
    /// ● ebd is the estimated bad debt associated to the auction's risk band (see table).
    /// ● f is the fee, default is 0.01.
    /// ● ba is the bid amount, default is £20.
    func era(fee: Float = 0.01) -> Decimal {
        let flatValue = NSDecimalNumber(value: 1)
        let auctionRate = NSDecimalNumber(value: rate)
        let feeDecimal = NSDecimalNumber(value: fee)
        let bidAmountPounds = NSDecimalNumber(value: amountCents / 100)
        let estimatedBadDebt = NSDecimalNumber(decimal: riskBandEnum.estimatedBadDebt)
        let firstPart = flatValue.adding(auctionRate).subtracting(estimatedBadDebt).subtracting(feeDecimal)
        let secondPart = firstPart.multiplying(by: bidAmountPounds)
        return secondPart.decimalValue
    }
}
