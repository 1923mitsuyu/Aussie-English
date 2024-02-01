//
//  CountDownTimerView.swift
//  AusApp
//
//  Created by 三露郁史 on 16/1/2024.
//

import SwiftUI

struct CountdownView: View {
    @State private var countdown = 3
    @State private var timer: Timer?
    @State private var showGamePlayView = false
    let NumberQuestionLeft : Int
    let numToPass : Int
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            NavigationStack {
                VStack {
                    Text(countdown > 0 ? "\(countdown)" : "Start!")
                        .font(.largeTitle)
                        .foregroundColor(countdown == 0 ? .blue : .red)
                        .onAppear {
                            startCountdown()
                        }
                }
                .navigationDestination(isPresented: $showGamePlayView)
                {
                    PlayGameView(numberOfLeftWords: NumberQuestionLeft, maxNumQuestion: numToPass, wordsList: DeveloperPreview())
                }
            }
            .navigationBarBackButtonHidden()
        }
    }

    func startCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if countdown > 0 {
                countdown -= 1
            } else {
                // The countdown has reached 0, stop the timer or perform any action needed for game start.
                timer?.invalidate()
                showGamePlayView = true
            }
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(NumberQuestionLeft: 3, numToPass: 3)
    }
}

