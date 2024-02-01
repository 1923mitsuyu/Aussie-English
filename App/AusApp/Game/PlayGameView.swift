import SwiftUI
import SwiftData

struct PlayGameView: View {
    
    @Environment(\.modelContext) var context
    @State private var playerScore : Int = 0
    @State private var idOfword = 0
    @State private var isGameEnded = false
    @State private var backToTitle = false
    @State private var buttonClicked = false
    @State private var showTrueOrFalse = "Choose your answer!"
    @State var correctWords : [Int] = []
    @State var usedMoves: [Int] = []
    @State var mistakenMoves: [Int] = []
    @State var firstChoice = "ビール"
    @State var secondChoice = "炭酸飲料"
    
    // Data passed from the previos view
    @State var numberOfLeftWords : Int
    let maxNumQuestion: Int
    let wordsList : DeveloperPreview
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                // Set the blue wallpaper
                Image("image1")
                    .opacity(0.9)
            
                    VStack{
                        // Remaining number of words
                        Text(numberOfLeftWords == 1 ? "1 word left" : "\(String(numberOfLeftWords)) words left")
                            .frame(maxWidth: 350, alignment: .leading)
                            .bold()
                            .padding(.top, 225)
                            .padding(.bottom, 30)
                            .padding(.leading)
                            .foregroundStyle(.white)
                        
                        // Word for the question
                        Text(wordsList.listings[idOfword].word)
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
                            // First Choice
                            Button(action: {
                                // Call the function to check the answer
                                checkAnswer(answer : firstChoice)
                                // Prevent the double click
                                buttonClicked = true
                            }) {
                                Text(firstChoice)
                                    .modifier(PlayerGameViewModifier())
                            }
                            .disabled(buttonClicked)
                            
                            // Second Choice
                            Button(action: {
                                // Call the function to check the answer
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
                                .frame(width: 100, height: 55) // changed
                                .bold()
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                .font(.title3)
                                .padding(.top,20)
                        }
                        // // Leads to the section to see the words that the player has learnt (BrowseWordsView())
                        Button(action: { backToTitle = true
                        }) {
                            Text("Quit the game")
                                .frame(width: 190, height: 55)  // changed
                                .bold()
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20.0))
                                .font(.title3)
                                .padding(.top,20)
                                .padding(.bottom, 220)
                        }
                    }
                    .navigationDestination(isPresented: $isGameEnded) {
                        ResultView(arrayToPass: mistakenMoves, dataToPass: playerScore, wordsList: DeveloperPreview())
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
        firstChoice = "ビール"
        secondChoice = "炭酸飲料"
        numberOfLeftWords = maxNumQuestion
        usedMoves = []
        mistakenMoves = []
    }
    
    // A function to choose a word and two choices
    func generateWordAndChoices() {
       
        let lengthOfArray = wordsList.listings.count
        
        // Check if the game is over
        guard usedMoves.count < maxNumQuestion else {
                print("All numbers have been used.")
                return
            }
        
        // Randomise a number (the length of the array is the maximum) to generate a new word
        idOfword = Int.random(in: 1..<lengthOfArray)
        
        // Check if the randomely generated number has been alreday used
        while usedMoves.contains(idOfword) {
            // Generate a number again
            idOfword = Int.random(in: 1..<lengthOfArray)
        }

        // Call a function to suffle the two choices
        let randomMeaning = getRandomMeaning()
        firstChoice = randomMeaning.firstChoice
        secondChoice = randomMeaning.secondChoice
    }

    // A function to check if the game is over
    func checkGameEnded() {
        
        // Finish the game once all words in the array have been used
        if usedMoves.count == maxNumQuestion || numberOfLeftWords == 0 {
            isGameEnded = true
            
            print(correctWords)
            
            // Insert all words the player got right to a list
            let wordsToShow = DisplayedWordsObject(correctWords: correctWords)
            context.insert(wordsToShow)
            
            // Insert the score based on the number of words the player choose
            if maxNumQuestion == 10 {
                let playerItem = PlayerInfo1(playerScore: playerScore)
                context.insert(playerItem)
            }
            else if maxNumQuestion == 20 {
                let playerItem = PlayerInfo2(playerScore: playerScore)
                context.insert(playerItem)
            }
            else if maxNumQuestion == 30 {
                let playerItem = PlayerInfo3(playerScore: playerScore)
                context.insert(playerItem)
            }
            else if maxNumQuestion == 40 {
                let playerItem = PlayerInfo4(playerScore: playerScore)
                context.insert(playerItem)
            }
        }
    }
    
    // A function to check the answer
    func checkAnswer(answer : String) {
        
        // Add the index for the chosen word to the list
        usedMoves.append(idOfword)
        
        // When the correct answer is chosen
        if answer == wordsList.listings[idOfword].meaning1 {
            playerScore += 1
            showTrueOrFalse = "⭕️"
            // Add the index for the correct words to the list
            correctWords.append(idOfword)
        }
        // When the incorrect answer is chosen
        else {
            showTrueOrFalse = "❌"
            
            // Add the index for the incorrect words to the list
            mistakenMoves.append(idOfword)
            
            // Display the list that contains the index of the incorrect words
            print("The words you got wrong\(mistakenMoves)")
        }
        
        // Cause a bit of delay
        let interval: TimeInterval = 0.8
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
       
        // Assign choices based on the num variable
        if num == 0 {
            return (firstChoice: wordsList.listings[idOfword].meaning1, secondChoice: wordsList.listings[idOfword].meaning2)
        }
        else {
            return (firstChoice: wordsList.listings[idOfword].meaning2, secondChoice: wordsList.listings[idOfword].meaning1)
        }
    }
}

#Preview {
    PlayGameView(numberOfLeftWords: 3, maxNumQuestion: 3, wordsList: DeveloperPreview())
}

// Custom modifier
struct PlayerGameViewModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 165, height: 80) // chagend
            .foregroundColor(.red)
            .bold()
            .font(.title2) // chagend 
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 40.0))
            .padding(10)
    }
}


