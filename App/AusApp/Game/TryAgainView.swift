//
//  TryAgainView.swift
//  AusApp
//
//  Created by 三露郁史 on 16/1/2024.
//

import SwiftUI

struct TryAgainView: View {
    
    @State private var idOfword = 0
    @State private var playerScore = 0
    @State private var showTrueOrFalse = "Choose your answer!"
    @State private var isGameEnded = false
    @State var backToTitle = false
    @State private var buttonClicked = false
    @State var firstChoice = ""
    @State var secondChoice = ""
    @State var usedMoves: [Int] = []
    @State var mistakenMoves2: [Int] = []
    
    // Data passed from the previos view
    @State var arrayToPass2 : [Int]
    @State var numberOfLeftWords = 0
    
    let wordsList : DeveloperPreview
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Set the blue wallpaper
                Image("image1")
                    .opacity(0.9)
                
                VStack{
                    // Word for the question
                    Text(numberOfLeftWords == 1 ? "1 word left" : "\(String(numberOfLeftWords)) words left")
                        .frame(maxWidth: 350, alignment: .leading)
                        .bold()
                        .padding(.top, 225)
                        .padding(.bottom, 30)
                        .padding(.leading)
                        .foregroundStyle(.white)
                    
                    Text(wordsList.listings[arrayToPass2[idOfword]].word)
                        .onAppear {
                            numberOfLeftWords = arrayToPass2.count
                            firstChoice = wordsList.listings[arrayToPass2[idOfword]].meaning1
                            secondChoice = wordsList.listings[arrayToPass2[idOfword]].meaning2
                        }
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                        .bold()
                        .frame(width: 300, height: 90)
                        .background(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 30.0))
                        .padding(.bottom, 60)
                    
                    // Text (choose your answer / ⚪︎ / ×)
                    Text(showTrueOrFalse)
                        .bold()
                        .frame(height: 5)
                        .foregroundStyle(.white)
                        .font(showTrueOrFalse == "Choose your answer!" ? .system(size: 30): .system(size: 80))
                        .padding(.top, 10)
                    
                    HStack{
                        Spacer()
                        Button(action: {
                            // Check the answer
                            checkAnswer(answer : firstChoice)
                            // Prevent the double click
                            buttonClicked = true
                        }) {
                            Text(firstChoice)
                                .modifier(PlayerGameViewModifier())
                        }
                        .disabled(buttonClicked)
                        
                        Button(action: {
                            // Check the answer
                            checkAnswer(answer : secondChoice)
                            // Prevent the double click
                            buttonClicked = true
                        }) {
                            Text(secondChoice)
                                .modifier(PlayerGameViewModifier())
                        }
                        .disabled(buttonClicked)
                        Spacer()
                    }
                    .padding(.top,60)
                    
                    Text("Points")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .bold()
                        .padding(.top,20)
                        .padding(.bottom,2)
                    
                    Text(String(playerScore))
                        .foregroundStyle(.white)
                        .font(.title2)
                        .bold()
                    
                    Button(action: {
                        // Call the function to reset the game
                        resetGame()
                    }) {
                        Text("Reset")
                            .frame(width: 100, height: 55)
                            .bold()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                            .font(.title3)
                            .padding(.top,20)
                    }
                    
                    Button(action: { backToTitle = true
                    }) {
                        Text("Quit the game")
                            .frame(width: 190, height: 55)
                            .bold()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                            .font(.title3)
                            .padding(.top,20)
                            .padding(.bottom,220)
                    }
                }
                .navigationDestination(isPresented: $isGameEnded) {
                    ResultView(arrayToPass: mistakenMoves2, dataToPass: playerScore, wordsList: DeveloperPreview())
                }
                .navigationDestination(isPresented: $backToTitle) { ContentView() }
                // Hide the back button at the top left corner
                .navigationBarBackButtonHidden()
            }
        }
    }
    
    // A function to reset the game
    func resetGame() {
        idOfword = 0
        showTrueOrFalse = "Choose your answer!"
        playerScore = 0
        numberOfLeftWords = arrayToPass2.count
        firstChoice = wordsList.listings[arrayToPass2[idOfword]].meaning1
        secondChoice = wordsList.listings[arrayToPass2[idOfword]].meaning2
        usedMoves = []
        mistakenMoves2 = []
    }
            
    // A function to choose a word and two choices
    func generateWordAndChoices() {
    
        let lengthOfArray = arrayToPass2.count
               
        // Check if the game is over
        guard usedMoves.count < lengthOfArray else {
                print("All numbers have been used.")
                return
            }
        
        // Randomise a number (the length of the array is the maximum) to generate a new word
        idOfword = Int.random(in: 1..<lengthOfArray)
        
        // Check if the randomly generated number has been already used
        while usedMoves.contains(idOfword) {
            // generate a number again
            idOfword = Int.random(in: 1..<lengthOfArray)
        }
        
        // Call a function to generate two choices
        let randomMeaning = getRandomMeaning()
        firstChoice = randomMeaning.firstChoice
        secondChoice = randomMeaning.secondChoice
    }

    // A function to check if the game is over
    func checkGameEnded() {
        // Finish the game once all words in the array have been used
        if usedMoves.count == arrayToPass2.count {
           isGameEnded = true
        }
    }
    
    // A function to check the answer
    func checkAnswer(answer : String) {
        // Add the index for the chosen word to the list
        usedMoves.append(idOfword)
            
        // When the correct answer is chosen
        if answer == wordsList.listings[arrayToPass2[idOfword]].meaning1
        {
            playerScore += 1
            showTrueOrFalse = "⭕️"
        }
        // When the incorrect answer is chosen
        else {
            showTrueOrFalse = "❌"
            // Add the index for the incorrect to the list
            mistakenMoves2.append(arrayToPass2[idOfword])
            // Display the list that contains the index of the incorrect words
            print("The words you got wrong\(mistakenMoves2)")
        }
        
        // Cause a bit of delay
        let interval: TimeInterval = 0.7
        DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: {
            // Generate a random word
            generateWordAndChoices()
            // Check if the game is over
            checkGameEnded()
            // Enable buttons
            buttonClicked = false
            showTrueOrFalse = "Choose your answer!"
            numberOfLeftWords -= 1
        })
    }
    
    // A function to suffle the two choices
    func getRandomMeaning() -> (firstChoice:String, secondChoice: String) {
        // Randomise a number (0 or 1)
        let num = Int.random(in: 0...1)
        print(num)
        
        // Assign choices based on the num variable
        if num == 0 {
            return (firstChoice: wordsList.listings[arrayToPass2[idOfword]].meaning1, secondChoice: wordsList.listings[arrayToPass2[idOfword]].meaning2)
        }
        else {
            return (firstChoice: wordsList.listings[arrayToPass2[idOfword]].meaning2, secondChoice: wordsList.listings[arrayToPass2[idOfword]].meaning1)
        }
    }
}

#Preview {
    TryAgainView(arrayToPass2: [9,8], wordsList: DeveloperPreview())
}

struct PlayerGameViewModifier2 : ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 160, height: 80)
            .foregroundStyle(.red)
            .bold()
            .font(.title)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 40.0))
            .padding(10)
    }
}
