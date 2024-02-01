//
//  AusAppApp.swift
//  AusApp
//
//  Created by 三露郁史 on 16/1/2024.
//

import SwiftUI
import SwiftData

@main
struct English_Learning_AppApp: App {
    var body: some Scene {
        WindowGroup {
            GreetingView()
                 // Disabling Dynamic Type
                .environment(\.sizeCategory, .medium)
        }
        .modelContainer(for: [DisplayedWordsObject.self, PlayerInfo1.self , PlayerInfo2.self,PlayerInfo3.self,PlayerInfo4.self])
    }
}

