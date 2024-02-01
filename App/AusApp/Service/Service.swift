//
//  Service.swift
//  AusApp
//
//  Created by 三露郁史 on 20/1/2024.
//

import Foundation

class ExploreService {
    func fetchListings() async throws -> [Word] {
        return DeveloperPreview.shared.listings
    }
}
