//
//  PlayerItem.swift
//  AusApp
//
//  Created by 三露郁史 on 16/1/2024.
//

import Foundation
import SwiftData

class SearchedWordsObject : ObservableObject {
    
    @Published var searchWord = ""
    var listings = [Word] ()
    private var listingsCopy = [Word]()
    private let service : ExploreService
        
    init(service: ExploreService) {
        self.service = service
        Task { await fetchListing() }
    }
    
    func fetchListing() async {
        do {
            self.listings = try await service.fetchListings()
            self.listingsCopy = listings
        } catch {
            print("DEBUG: Failed to fetch listings with errors: \(error.localizedDescription)")
            
        }
    }
    
    func updateListingsForLocation() {
        
        if searchWord.isEmpty {
           
            self.listings = self.listingsCopy
        } else {
            let filteredListings = listings.filter({
                $0.word.lowercased().contains(searchWord.lowercased())
                // $0.word.lowercased() == searchWord.lowercased()
            })
            self.listings = filteredListings
        }
    }
}

@Model
class DisplayedWordsObject {
    
       var correctWords: [Int]

       init(correctWords: [Int]) {
           self.correctWords = correctWords
       }
   }

@Model
class PlayerInfo1 {
    
    var playerScore : Int
   
    init(playerScore: Int) {
        self.playerScore = playerScore
    }
}

@Model
class PlayerInfo2 {
    
    var playerScore : Int
    
    init(playerScore: Int) {
        self.playerScore = playerScore
    }
}

@Model
class PlayerInfo3 {
    
    var playerScore : Int
   
    init(playerScore: Int) {
        self.playerScore = playerScore
    }
}

@Model
class PlayerInfo4 {
    
    var playerScore : Int
    
    init(playerScore: Int) {
        self.playerScore = playerScore
    }
}




