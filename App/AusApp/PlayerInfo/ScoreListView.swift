//
//  ShowScoreView.swift
//  AusApp
//
//  Created by 三露郁史 on 16/1/2024.
//

import SwiftUI
import SwiftData

struct ScoreListView: View {
    
    @Environment(\.modelContext) var context
    
    static var descriptor: FetchDescriptor<PlayerInfo1> {
        var descriptor = FetchDescriptor<PlayerInfo1>(sortBy: [SortDescriptor(\.playerScore, order: .reverse)])
        descriptor.fetchLimit = 3
        return descriptor
    }
    @Query(descriptor) var playerItems: [PlayerInfo1]

    static var descriptor2: FetchDescriptor<PlayerInfo2> {
        var descriptor2 = FetchDescriptor<PlayerInfo2>(sortBy: [SortDescriptor(\.playerScore, order: .reverse)])
        descriptor2.fetchLimit = 3
        return descriptor2
    }
    @Query(descriptor2) var playerItems2: [PlayerInfo2]

    static var descriptor3: FetchDescriptor<PlayerInfo3> {
        var descriptor3 = FetchDescriptor<PlayerInfo3>(sortBy: [SortDescriptor(\.playerScore, order: .reverse)])
        descriptor3.fetchLimit = 3
        return descriptor3
    }
    @Query(descriptor3) var playerItems3: [PlayerInfo3]
    
    static var descriptor4: FetchDescriptor<PlayerInfo4> {
        var descriptor4 = FetchDescriptor<PlayerInfo4>(sortBy: [SortDescriptor(\.playerScore, order: .reverse)])
        descriptor4.fetchLimit = 3
        return descriptor4
    }
    @Query(descriptor4) var playerItems4: [PlayerInfo4]
        
    @State var backToTitle = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Set the blue wallpaper
                Image("image1")
                    .opacity(0.9)
                 
                VStack{
                    // Scores for 10 words
                    VStack {
                        HStack {
                            Text("Score (10 words)")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .underline()
                            
                            Spacer()
                            if !playerItems.isEmpty {
                                Button(action: {
                                    do {
                                        try context.delete(model: PlayerInfo1.self)
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
                                }
                            }
                        }
                        .frame(maxWidth: 230, alignment: .center)
                        .padding(.leading,85)
                        .padding(.bottom,10)
                        // Display up to 3 scores from the highest one
                        ForEach(Array(playerItems.enumerated()), id: \.offset) { offset, item in
                            if offset == 0 {
                                Text("1st score : \(String(item.playerScore))")
                                    .padding(.bottom,5)
                            }
                            else if offset == 1 {
                                Text("2nd score : \(String(item.playerScore))")
                                    .padding(.bottom,5)
                            }
                            else if offset == 2 {
                                Text("3rd score : \(String(item.playerScore))")
                                    .padding(.bottom,5)
                                
                            }
                        }
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    }
                    .frame(height: 110, alignment: .top)
                    .padding(.bottom,30)
                    
                    // Scores for 20 words
                    VStack {
                        HStack {
                            Text("Score (20 words)")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .underline()
                            
                            Spacer()
                            if !playerItems2.isEmpty {
                                Button(action: {
                                    do {
                                        try context.delete(model: PlayerInfo2.self)
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
                                }
                            }
                        }
                        .frame(maxWidth: 230, alignment: .center)
                        .padding(.leading,85)
                        .padding(.bottom,10)
                        
                        // Display up to 3 scores from the highest one
                        ForEach(Array(playerItems2.enumerated()), id: \.offset) { offset2, item2 in
                            if offset2 == 0 {
                                Text("1st score :  \(String(item2.playerScore))")
                                    .padding(.bottom,5)
                            }
                            else if offset2 == 1 {
                                Text("2nd score : \(String(item2.playerScore))")
                                    .padding(.bottom,5)
                            }
                            else if offset2 == 2 {
                                Text("3rd score : \(String(item2.playerScore))")
                                    .padding(.bottom,5)
                            }
                        }
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    }
                    .frame(height: 110, alignment: .top)
                    .padding(.bottom,30)
                    
                    // Scores for 30 words
                    VStack {
                        HStack {
                            Text("Score (30 words)")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .underline()
                            
                            Spacer()
                            if !playerItems3.isEmpty {
                                Button(action: {
                                    do {
                                        try context.delete(model: PlayerInfo3.self)
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
                                }
                            }
                        }
                        .frame(maxWidth: 230, alignment: .center)
                        .padding(.leading,85)
                        .padding(.bottom,10)
                        
                        // Display up to 3 scores from the highest one
                        ForEach(Array(playerItems3.enumerated()), id: \.offset) { offset3, item3 in
                            if offset3 == 0 {
                                Text("1st score :  \(String(item3.playerScore))")
                                    .padding(.bottom,5)
                            }
                            else if offset3 == 1 {
                                Text("2nd score : \(String(item3.playerScore))")
                                    .padding(.bottom,5)
                            }
                            else if offset3 == 2 {
                                Text("3rd score : \(String(item3.playerScore))")
                                    .padding(.bottom,5)
                            }
                        }
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    }
                    .frame(height: 110, alignment: .top)
                    .padding(.bottom,30)
                    
                    // Scores for 40 words
                    VStack {
                        HStack {
                            Text("Score (40 words)")
                                .font(.title3)
                                .foregroundStyle(.white)
                                .underline()
                            
                            Spacer()
                            if !playerItems4.isEmpty {
                                Button(action: {
                                    do {
                                        try context.delete(model: PlayerInfo4.self)
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
                                }
                            }
                        }
                        .frame(maxWidth: 230, alignment: .center)
                        .padding(.leading,85)
                        .padding(.bottom,10)
                        
                        // Display up to 3 scores from the highest one
                        ForEach(Array(playerItems4.enumerated()), id: \.offset) { offset4, item in
                            if offset4 == 0 {
                                Text("1st score :  \(String(item.playerScore))")
                                    .padding(.bottom,5)
                            }
                            else if offset4 == 1 {
                                Text("2nd score : \(String(item.playerScore))")
                                    .padding(.bottom,5)
                            }
                            else if offset4 == 2 {
                                Text("3rd score : \(String(item.playerScore))")
                                    .padding(.bottom,5)
                            }
                        }
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    }
                    .frame(height: 110, alignment: .top)
                    .padding(.bottom,60)
                    
                    // Leads to the title page (ContentView())
                    Button(action: {
                        backToTitle = true
                    }) {
                        Text("Back")
                            .foregroundStyle(.white)
                            .font(.title3)
                            .bold()
                    }
                }
            }
        }
        .navigationDestination(isPresented: $backToTitle) { ContentView() }
        // Hide the back button at the top left corner
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ScoreListView()
}


