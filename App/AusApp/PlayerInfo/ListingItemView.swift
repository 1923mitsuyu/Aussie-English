//
//  ListingItemView.swift
//  AusApp
//
//  Created by 三露郁史 on 24/1/2024.
//

import SwiftUI

struct ListingItemView: View {
    
    let listing: Word
    
    var body: some View {
        
        Text("\(listing.wordID)")
            .frame(width: 30, height: 30)
            .background(.gray)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            .padding(.trailing,10)
        
        Text("\(listing.word)  :  \(listing.meaning1)")
            .fontWeight(.semibold)
            .padding(.leading, 5)
    }
}

#Preview {
    ListingItemView(listing: DeveloperPreview.shared.listings[0])
}
