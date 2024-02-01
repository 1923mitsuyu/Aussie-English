//
//  NumberOfWordsView.swift
//  AusApp
//
//  Created by 三露郁史 on 16/1/2024.
//

import SwiftUI

struct ChooseWordNumberView: View {
    
    @State private var startPlay = false
    @State var backToTitle = false
    @State private var NumQuestion = 0
    @State private var NumQuestionLeft = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Set the blue wallpaper
                Image("image1")
                    .opacity(0.9)
                
                VStack {
                    Text("How many words?")
                        .font(.system(size: 23))
                        .foregroundStyle(.white)
                        .padding(.top,220)
                        .padding(.bottom,50)
                        .fontWeight(.black)
                    
                    // Leads to the count down timer (CountDownTimerView)
                    Button(action: {
                        startPlay = true
                        NumQuestion = 10
                        NumQuestionLeft = 10
                    }) {
                        Text("10 words")
                            .modifier(ChooseNumbeOfWordsViewModifier())
                    }
                    // Leads to the count down timer (CountDownTimerView)
                    Button(action: {
                        // Move to CountdownView() view
                        startPlay = true
                        NumQuestion = 20
                        NumQuestionLeft = 20
                    }) {
                        Text("20 words")
                            .modifier(ChooseNumbeOfWordsViewModifier())
                    }
                    // Leads to the count down timer (CountDownTimerView)
                    Button(action: {
                        // Move to CountdownView() view
                        startPlay = true
                        NumQuestion = 30
                        NumQuestionLeft = 30
                    }) {
                        Text("30 words")
                            .modifier(ChooseNumbeOfWordsViewModifier())
                    }
                    // Leads to the count down timer (CountDownTimerView)
                    Button(action: {
                        // Move to CountdownView() view
                        startPlay = true
                        NumQuestion = 40
                        NumQuestionLeft = 40
                    }) {
                        Text("40 words")
                            .modifier(ChooseNumbeOfWordsViewModifier())
                    }
                
                    // Leads to the title page (ContentView())
                    Button(action: { backToTitle = true
                    }) {
                        Text("Back")
                            .foregroundStyle(.white)
                            .bold()
                            .font(.title3)
                            .padding(.top, 70)
                            .padding(.bottom, 165)
                    }
                }
            }
        }
        .navigationDestination(isPresented: $startPlay) {
            CountdownView(NumberQuestionLeft : NumQuestionLeft, numToPass : NumQuestion)
        }
        .navigationDestination(isPresented: $backToTitle) {
            ContentView()
        }
        // Hide the back button at the top left corner
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    ChooseWordNumberView()
}

// Custom modifier
struct ChooseNumbeOfWordsViewModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
           
            .font(.title)
            .foregroundStyle(.blue)
            .frame(width: 240, height: 50)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding(.bottom,40)
            .bold()
    }
}
