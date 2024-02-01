//
//  TitlePageView.swift
//  AusApp
//
//  Created by 三露郁史 on 16/1/2024.
//

import SwiftUI

struct GreetingView: View {
    
    @State private var jumpToGame = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Set the blue wallpaper
                Image("image1")
                    .opacity(0.9)
                
                Text("\(getGreeting())!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            .onAppear {
                // Cause a delay of 1 second 
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    jumpToGame = true
                }
            }
            .navigationDestination(isPresented: $jumpToGame) { ContentView() }
        }
    }
}
    
    // A function to generate a greeting depending on the time of the day
    func getGreeting() -> String {
        
        let currentDate = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDate)
        
        switch hour {
            case 0..<12:
                return "Good morning"
            case 12..<17:
                return "Good afternoon"
            default:
                return "Good evening"
            }
    }

#Preview {
    GreetingView()
}


