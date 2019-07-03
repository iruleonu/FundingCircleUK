//
//  APIService+FetchAuctions.swift
//  IRCV
//
//  Created by Nuno Salvador on 03/07/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import Combine

protocol APIFetchAuctionsProtocol {
    func fetchAuctions() -> AnyPublisher<[Auction], APIServiceError>
}

extension APIServiceImpl: APIFetchAuctionsProtocol {
    func fetchAuctions() -> AnyPublisher<[Auction], APIServiceError> {
        let properties = Resource.auctions.requestProperties
        let urlRequest = URLRequest(url: apiBaseUrl.appendingPathComponent(properties.path))
        let parseData: ((Data, URLResponse)) -> AnyPublisher<[Auction], APIServiceError> = { tuple in
            return AnyPublisher { subscriber in
                do {
                    let auctionsResponse = try JSONDecoder.IRJSONDecoder().decode(AuctionsResponse.self, from: tuple.0)
                    _ = subscriber.receive(auctionsResponse.items)
                } catch {
                    subscriber.receive(completion: .failure(APIServiceError.parsing(error: error)))
                }
            }
        }
        
        return session.fetchData(urlRequest)
            .mapError { APIServiceError.network(error: $0) }
            .flatMap(parseData)
            .eraseToAnyPublisher()
    }
}
