//
//  AuctionsScreenViewModel.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

final class AuctionsScreenViewModel: BindableObject {
    private(set) var routing: AuctionsScreenRouting
    private var apiService: APIFetchAuctionsProtocol
    
    var didChange = PassthroughSubject<AuctionsScreenViewModel, Never>()
    
    private(set) var auctions: [Auction] {
        didSet {
            didChange.send(self)
        }
    }
    
    private var cancellable: Cancellable? {
        didSet { oldValue?.cancel() }
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    init(routing: AuctionsScreenRouting, network: APIFetchAuctionsProtocol) {
        self.routing = routing
        self.apiService = network
        self.auctions = []
    }
    
    func onAppear() {
        didChange.send(self)
        fetchAuctions()
    }
    
    private func fetchAuctions() {
        cancellable = apiService.fetchAuctions()
            .catch({ (error) -> AnyPublisher<[Auction], APIServiceError> in
                return AnyPublisher { subscriber in
                    _ = subscriber.receive([])
                }
            })
            .sink { [weak self] (auctions) in
                guard let self = self else { return }
                self.auctions = auctions
        }
    }
}
