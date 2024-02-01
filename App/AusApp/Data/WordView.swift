//
//  WordView.swift
//  AusApp
//
//  Created by 三露郁史 on 16/1/2024.
//

import SwiftUI

struct Word : Identifiable, Hashable, Comparable {
    
    static func < (lhs: Word, rhs: Word) -> Bool { return lhs.word < rhs.word }
    
    let id = UUID()
    var wordID : Int
    var word: String
    var meaning1: String
    var meaning2: String
    var normalWord : String
    var example1 : String
    var example2:String
    var translation1: String
    var translation2 : String
    
    static func == (lhs: Word, rhs: Word) -> Bool { lhs.word == rhs.word && lhs.meaning1 == rhs.meaning1 && lhs.meaning2 == rhs.meaning2 }
}

