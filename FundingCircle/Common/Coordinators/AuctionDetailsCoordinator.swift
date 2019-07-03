//
//  WorkDetailsCoordinator.swift
//  IRCV
//
//  Created by Nuno Salvador on 17/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import UIKit

protocol AuctionDetailsRouting {
    
}

final class AuctionDetailsCoordinator {
    private let builders: AuctionDetailsScreenChildBuilders
    
    init(builders b: AuctionDetailsScreenChildBuilders) {
        builders = b
    }
}

extension AuctionDetailsCoordinator: AuctionDetailsRouting {
    
}
