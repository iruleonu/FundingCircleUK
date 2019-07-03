//
//  AuctionsScreenAuctionCell.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import SwiftUI

struct AuctionsScreenAuctionCell: View {
    var auction: Auction
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            VStack(alignment: .leading, spacing: 5) {
                Text(auction.title)
                    .color(.primary)
                    .lineLimit(2)
                    .font(.largeTitle)
                
                Text("\(auction.amountCents)")
                    .color(.primary)
                    .font(.subheadline)
            }
            
            Spacer()
            
            Text(auction.riskBand)
                .color(.primary)
                .font(.footnote)
                .lineLimit(nil)
        }
    }
}

#if DEBUG
struct AuctionsScreenAuctionCell_Previews: PreviewProvider {
    static var previews: some View {
        let auction = Auction(id: 2,
                              title: "McLaughlin-Fahey",
                              rate: 0.01,
                              amountCents: 8000000,
                              term: 48,
                              riskBand: "A",
                              closeTime: Date())
        return AuctionsScreenAuctionCell(auction: auction)
    }
}
#endif
