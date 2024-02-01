//
//  ResultView.swift
//  AusApp
//
//  Created by 三露郁史 on 16/1/2024.
//

import SwiftUI

struct ResultView: View {
    
    @State var playAgain = false
    @State var backToTitle = false
    @State var palyAgainWrongWords = false
    // Data passed from the previos view
    @State var arrayToPass: [Int]
    let dataToPass: Int
    
    let wordsList : DeveloperPreview
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                // Set the blue wallpaper
                Image("image1")
                    .opacity(0.9)
                
                VStack{
                    Text("You got \(dataToPass) points!")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.top,245)
                        .padding(.bottom, 20)
                    
                    Text("Check the words you got wrong!")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.bottom,10)
                    
                    // List of the incorrect words
                    ScrollView {
                        VStack {
                            ForEach(arrayToPass, id: \.self) { index in
                                HStack {
                                    Text("・ \(wordsList.listings[index].word)")
                                        .padding(.leading,12)
                                    Text(":  \(wordsList.listings[index].meaning1)")
                                }
                                .foregroundStyle(.black)
                                .frame(width: 290, height: 36, alignment: .leading)
                                .fontWeight(.semibold)
                                .padding(.vertical, 4)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                    // Leads to the section to try the words that the player got wrong
                    Button(action: { palyAgainWrongWords = true
                    }) {
                        Text("Try only incorrect words")
                            .foregroundStyle(.blue)
                            .bold()
                            .frame(width: 265,height: 50)
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 30.0))
                            .font(.title3)
                            .foregroundStyle(.black)
                            .padding(.top,10)
                    }
                    HStack{
                        // Leads to the title page (ContentView())
                        Button(action: {
                            backToTitle = true
                            arrayToPass = []
                        }) {
                            Text("Back")
                                .foregroundStyle(.blue)
                                .bold()
                                .frame(width: 105,height: 50)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 30.0))
                                .font(.title3)
                                .padding(.bottom,245)
                                .padding(.top,10)
                                .padding(.trailing,5)
                            
                        }
                        // Leads to the section to choose the number of words the player will study (NumberOfWordsView())
                        Button(action: {
                            playAgain = true
                            arrayToPass = []
                        }) {
                            Text("Play Again")
                                .foregroundStyle(.blue)
                                .bold()
                                .frame(width: 138,height: 50)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 30.0))
                                .font(.title3)
                                .padding(.bottom,245)
                                .padding(.top,10)
                                .padding(.leading,5)
                        }
                    }
                }
                .navigationDestination(isPresented: $backToTitle) { ContentView() }
                .navigationDestination(isPresented: $palyAgainWrongWords) {
                    if arrayToPass.isEmpty { // jump to the title page if there is no words in the list
                        ContentView()
                    } else {
                        TryAgainView(arrayToPass2: arrayToPass, wordsList: DeveloperPreview())
                    }
                }
                .navigationDestination(isPresented: $playAgain) {  ChooseWordNumberView() }
                .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    ResultView(arrayToPass: [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], dataToPass: 5, wordsList: DeveloperPreview())
}

