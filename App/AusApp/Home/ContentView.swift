//
//  ContentView.swift
//  AusApp
//
//  Created by 三露郁史 on 16/1/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @StateObject var viewModel = SearchedWordsObject(service: ExploreService())
    @State private var chooseNumWords = false
    @State private var backToTitle = false
    @State private var seeScore = false
    @State private var seeWords = false
    @State private var seeRule = false
    @State private var changeSettings = false
    @State var searchWord = false
    @State var showCreateView = false
    @State private var number = 0
    
    var body: some View {
        NavigationStack {
            GeometryReader { _ in
            ZStack {
                // Set the wallpaper
                Image("image1")
                    .opacity(0.9)
                    
                ScrollView {
                    VStack {
                            // Call the function to display the date
                            Text(getTodayDateAndDay())
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .padding(.trailing,275)
                                .padding(.bottom,15)
                      
                            // Search Bar
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .imageScale(.small)
                                    .foregroundStyle(.white)
                                
                                TextField("Search words", text: $viewModel.searchWord)
                                    .frame(width: 260)
                                    .foregroundStyle(.white)
                                    .font(.subheadline)
                                    .onChange(of: viewModel.searchWord) {
                                        if viewModel.searchWord.isEmpty {
                                            searchWord = false
                                            viewModel.searchWord = ""
                                            viewModel.updateListingsForLocation()
                                        }
                                    }
                                    .onSubmit {
                                        viewModel.updateListingsForLocation()
                                        searchWord = true
                                        showCreateView = true
                                    }
                                    .sheet(isPresented: $showCreateView) {
                                        SearchView(viewModel: viewModel, lookForWord: $searchWord)
                                    }
                            }
                            .frame(height: 44)
                            .padding(.horizontal)
                            .overlay {
                                Capsule()
                                    .stroke(lineWidth: 2.0)
                                    .foregroundStyle(.white)
                            }
                            .padding(.bottom,50)
                            // End of the search bar
                            
                            // Australian flag
                            Image("image2")
                                .resizable()
                                .frame(width:200, height:100)
                                .padding(.bottom,30)
                               
                            Spacer()
                           
                            Text("G'day!")
                                .font(.largeTitle)
                                .fontWeight(.black)
                                .foregroundStyle(.white)
                                .padding(.bottom,30)
                            
                            Text("Click the button below!")
                                .font(.title)
                                .foregroundStyle(.white)
                                .bold()
                                .padding(.bottom,30)
                        
                            Button(action: { seeRule = true
                            }) {
                                Text("How to use the app")
                                    .frame(width: 220, height: 45)
                                    .foregroundStyle(.white)
                                    .bold()
                                    .underline()
                                    .padding(.bottom,30)
                            }
                            
                            HStack {
                                // Leads to the section to see the player's scores (ShowScoreView())
                                Button(action: { seeScore = true
                                }) {
                                    Text("Score")
                                        .frame(width: 115, height: 45)
                                        .font(.title3)
                                        .foregroundStyle(.blue)
                                        .bold()
                                        .background(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 30))
                                        .padding(.bottom,30)
                                        .padding(.leading)
                                }
                                // Leads to the section to see the words that the player has learnt (BrowseWordsView())
                                Button(action: { seeWords = true
                                }) {
                                    Text("Word List")
                                        .frame(width: 125, height: 45)
                                        .font(.title3)
                                        .foregroundStyle(.blue)
                                        .bold()
                                        .background(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 30))
                                        .padding(.bottom,30)
                                        .padding(.trailing,13)
                                }
                            }
                            // Leads to the section to choose the number of words the player will study (NumberOfWordsView())
                            Button(action: {
                                chooseNumWords = true
                            }) {
                                Text("Start")
                                    .frame(width: 250, height: 50)
                                    .font(.title3)
                                    .foregroundStyle(.blue)
                                    .bold()
                                    .background(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 30))
                            }
                            // Enables the transition to other views
                            .navigationDestination(isPresented: $seeScore) {
                                ScoreListView()
                            }
                            .navigationDestination(isPresented: $seeWords) {
                                BrowseWordsView(wordsList: DeveloperPreview())
                            }
                            .navigationDestination(isPresented: $seeRule) {
                                RuleView()
                            }
                            .navigationDestination(isPresented: $chooseNumWords) {
                                ChooseWordNumberView()
                            }
                            // Hide the back button at the top left corner
                            .navigationBarBackButtonHidden()
                        }
                        .padding(.top,195)
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            }
        }
    }

    // A function to get the current date
    func getTodayDateAndDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM "
        return dateFormatter.string(from: Date())
    }
}

#Preview {
    ContentView()
}


