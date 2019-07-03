//
//  AuctionDetailsScreen.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import SwiftUI

struct AuctionDetailsScreen : View {
    @ObjectBinding var viewModel: AuctionDetailsScreenViewModel
    
    var body: some View {
        let vm = viewModel
        return GeometryReader { container in
            ScrollView() {
                ScrollViewContentView(title: self.viewModel[\.title],
                                      rate: self.viewModel[\.rate],
                                      amountCents: self.viewModel[\.amountCents],
                                      term: self.viewModel[\.term],
                                      riskBand: self.viewModel[\.riskBand],
                                      closeTime: self.viewModel[\.closeTime])
                    .frame(idealWidth: container.size.width, minHeight: 400, alignment: .top)
                }.onAppear {
                    vm.onAppear()
            }
        }
    }
}

struct ScrollViewContentView : View {
    @Binding var title: String
    @Binding var rate: Float
    @Binding var amountCents: Int
    @Binding var term: Int
    @Binding var riskBand: String
    @Binding var closeTime: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .color(.primary)
                .lineLimit(2)
                .font(.largeTitle)
            
            HStack(alignment: .lastTextBaseline, spacing: 5) {
                Text("Rate: ")
                    .color(.primary)
                    .lineLimit(2)
                    .font(.callout)
                Text("\(rate)")
                    .color(.primary)
                    .font(.caption)
            }
            
            HStack(alignment: .lastTextBaseline, spacing: 5) {
                Text("Amount cents: ")
                    .color(.primary)
                    .lineLimit(2)
                    .font(.callout)
                Text("\(amountCents)")
                    .color(.primary)
                    .font(.subheadline)
            }
            
            HStack(alignment: .lastTextBaseline, spacing: 5) {
                Text("Term: ")
                    .color(.primary)
                    .lineLimit(2)
                    .font(.callout)
                Text("\(term)")
                    .color(.primary)
                    .font(.footnote)
                    .lineLimit(nil)
            }
            
            HStack(alignment: .lastTextBaseline, spacing: 5) {
                Text("Risk band: ")
                    .color(.primary)
                    .lineLimit(2)
                    .font(.callout)
                Text(riskBand)
                    .color(.primary)
                    .font(.footnote)
                    .lineLimit(nil)
            }
            
            HStack(alignment: .lastTextBaseline, spacing: 5) {
                Text("Closing time: ")
                    .color(.primary)
                    .lineLimit(2)
                    .font(.callout)
                Text(closeTime)
                    .color(.primary)
                    .font(.footnote)
                    .lineLimit(nil)
            }
            }
            .padding()
    }
}

#if DEBUG
struct WorkDetailsScreen_Previews : PreviewProvider {
    static var previews: some View {
        let auction = Auction(id: 2,
                              title: "McLaughlin-Fahey",
                              rate: 0.01,
                              amountCents: 8000000,
                              term: 48,
                              riskBand: "A",
                              closeTime: Date())
        return AuctionDetailsScreenBuilder().make(auction: auction)
    }
}
#endif

