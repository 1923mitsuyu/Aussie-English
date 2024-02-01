//
//  BrowseWordsView.swift
//  AusApp
//
//  Created by 三露郁史 on 17/1/2024.
//

import SwiftUI
import SwiftData

struct BrowseWordsView: View {
    
    @Environment(\.modelContext) var context
    @Query var playerInfos: [DisplayedWordsObject]
    @State private var uniqueWords: [Word] = []
    @State private var sortedUniqueWords: [Word] = []
    @State private var hasList = false
    @State private var backToTitle = false
    
    let wordsList : DeveloperPreview
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("image1")
                    .opacity(0.9)
                
                VStack {
                    HStack {
                        Text("Learned Words")
                            .font(.title2)
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                        Spacer()
                        
                        if hasList {
                            Button(action: {
                                do {
                                    // Delete all words
                                    try context.delete(model: DisplayedWordsObject.self)
                                    // Call the functioin to display the empty list after the data is deleted
                                    getUniqueWords()
                                    // Remove the delete button
                                    hasList = false
                                    
                                } catch {
                                    print("Failed to clear all Country and City data.")
                                }
                            }) {
                                Text("Delete")
                                    .foregroundColor(.red)
                                    .fontWeight(.medium)
                                    .frame(width: 60, height: 23)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                    .padding(.trailing,15)
                            }
                        }
                    }
                    .frame(maxWidth: 350, alignment: .leading)
                    .padding(.top,240)
                    .padding(.leading,10)
                    
                    Divider()
                        .overlay(.white)
                        .padding(.bottom,10)
                    
                    ScrollView {
                        VStack {
                            ForEach(uniqueWords.sorted(), id: \.self) { unique in
                                NavigationLink(destination: WordDetailView(listing: unique)) {
                                    HStack {
                                        ListingItemView(listing: unique)
                                    }
                                    .foregroundStyle(.black)
                                    .frame(width: 320,height: 43, alignment: .leading)
                                    .padding(.leading,10)
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                }
                            }
                        }
                        // Once this view appears, the function will be called to display the words
                        .onAppear {
                            getUniqueWords()
                        }
                    }
                    
                    Button(action: { backToTitle = true
                    }) {
                        Text("Back")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .bold()
                            .padding(.top,9)
                            .padding(.bottom,243)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $backToTitle) { ContentView() }
    }
        
    // A function to get the list to display 
    func getUniqueWords() {
        
        // Reset the list first
        uniqueWords.removeAll()
        
        Array(Set(playerInfos)).forEach { playerInfo in
            Array(Set(playerInfo.correctWords)).forEach { index in
                if index < wordsList.listings.count {
                    if !uniqueWords.contains(where: {$0 == wordsList.listings[index]}) {
                        uniqueWords.append(wordsList.listings[index])
                    }
                }
            }
        }
        // if the list is empty, the delete button is hidden
        if !uniqueWords.isEmpty {
            hasList = true
        }
    }
}

#Preview {
    BrowseWordsView(wordsList:DeveloperPreview())
}


