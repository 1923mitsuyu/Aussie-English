//
//  RuleView.swift
//  AusApp
//
//  Created by 三露郁史 on 29/1/2024.
//

import SwiftUI

struct RuleView: View {
    
    @State var backToTitle = false
    
    var body: some View {
        ZStack {
            Image("image1")
            
            VStack {
                Text("How to use this app")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .padding(.bottom,30)
                    .bold()
                
                VStack(alignment: .leading) {
                    Text("1. Start")
                        .padding(.bottom,2)
                        .fontWeight(.bold)
                        .padding(.leading,15)
                        
                    Text("- Play quizzes to learn new words.")
                        .fontWeight(.semibold)
                        .padding(.leading,15)
                
                    Text("- Try only the words you got wrong again.")
                        .padding(.bottom)
                        .fontWeight(.semibold)
                        .padding(.leading,15)
                    
                    Divider()
                        .overlay {
                            Color.white
                        }
                        .padding(.bottom)
                    
                    Text("2. Search bar")
                        .padding(.bottom,2)
                        .fontWeight(.bold)
                        .padding(.leading,15)
                    
                    Text("- Search for words. The list of all words will pop up if you hit the enter with the search bar empty.")
                        .padding(.bottom)
                        .fontWeight(.semibold)
                        .padding(.leading,15)
                    
                    Divider()
                        .overlay {
                            Color.white
                        }
                        .padding(.bottom)
                    
                    Text("3. Score")
                        .padding(.bottom,2)
                        .fontWeight(.bold)
                        .padding(.leading,15)
                    
                    Text("- Check out your scores. Delete them if you want to.")
                        .padding(.bottom)
                        .fontWeight(.semibold)
                        .padding(.leading,15)
                    
                    Divider()
                        .overlay {
                            Color.white
                        }
                        .padding(.bottom)
                    
                    Text("4. Word List")
                        .padding(.bottom,2)
                        .fontWeight(.bold)
                        .padding(.leading,15)
                    
                    Text("- Check out the words you learnt before with the example sentences. Delete the list if you want to. Tap each word if you are keen to learn how to use those words with examples.")
                        .padding(.bottom)
                        .fontWeight(.semibold)
                        .padding(.leading,15)
                    
                    Divider()
                        .overlay { Color.white }
                        .padding(.bottom)
                    
                }
                .foregroundStyle(.white)
                .frame(maxWidth: 370)
                .padding(.bottom)
            
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
            .navigationBarBackButtonHidden()
            .navigationDestination(isPresented: $backToTitle) { ContentView() }
        }
    }
}

#Preview {
    RuleView()
}
