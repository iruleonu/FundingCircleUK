//
//  AuctionsScreenView.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import SwiftUI

struct AuctionsScreenView : View {
    @ObjectBinding var viewModel: AuctionsScreenViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.auctions) { auction in
                    NavigationButton(destination: self.viewModel.routing.buildDetailedAuctionScreen(auction: auction)) {
                        AuctionsScreenAuctionCell(auction: auction)
                    }
                    }
                    .listRowInsets(EdgeInsets(top: 5, leading: 30, bottom: 5, trailing: 30))
                }
                .onAppear { self.viewModel.onAppear() }
                .navigationBarTitle(Text("Auctions"))
        }
    }
}

#if DEBUG
struct ActionsScreenView_Previews : PreviewProvider {
    static var previews: some View {
        return AuctionsScreenBuilder().make(network: APIServiceImpl.default)
    }
}
#endif
