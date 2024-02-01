//
//  WordDetailView.swift
//  AusApp
//
//  Created by 三露郁史 on 24/1/2024.
//

import SwiftUI

struct WordDetailView: View {
    
    // A function to make a part of the example sentences bold
    private func changeStringColor(_ text: String, targetWords: [String]) -> AttributedString {
        var attributedString = AttributedString(text)
        
        for targetWord in targetWords {
            if let range = attributedString.range(of: targetWord) {
                attributedString[range].font = .system(size: 17, weight: .semibold)
                // attributedString[range].foregroundColor = .red
            }
        }
        
        return attributedString
    }
    
    // The list of words to be highlighted 
    let targetWords = ["cold one", "ambo", "ambo", "arvo","Aussie","avo","barbie","bathers","bin","bloke","bloody","bloody oath", "bludger","bottle-o","brekkie","brolly","Cheers","choccy","chock-a-block","chuck","chuck a U-ie","chuck a sickie","cossie","crook","cuppa","down under","dunny","esky","exxy","flat out","G'day","Good onya","heaps of","hoon","shout","shouted","Maccas","mossies","Nah, yeah","outback","postie","reckon","ripper","runners","sanga","servo","sheila","smoko","snag","stuffed","sunnies","ta","tea","thongs","toastie","tucker","ute","veggies","Yeah, nah", "snags", "Bloody oath", "choccies", "bins", "sangas", "toasties"]
    
    let listing: Word
    @State private var backToTitle = false
    
    var body: some View {
        ZStack {
            Image("image1")
                .opacity(0.9)
            
                VStack {
                    Button(action: { backToTitle = true
                    }) {
                        Text("Back")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .bold()
                            .padding(.top,240)
                            .padding(.bottom,70)
                            .frame(maxWidth: 350, alignment: .leading)
                    }
                    
                    Text(listing.word)
                        .font(.system(size: 25))
                        .bold()
                        .padding(.bottom,10)
                    
                    Text(listing.meaning1)
                        .fontWeight(.semibold)
                        .bold()
                    
                    Divider()
                        .frame(minHeight: 0.6)
                        .background(.white)
                        .padding(.vertical,25)
                    
                    VStack(alignment:.leading) {
                        Text(changeStringColor(listing.example1, targetWords: targetWords))
                            .padding(.bottom,10)
                        
                        Text(listing.translation1)
                            .padding(.bottom,10)
                            
                        Divider()
                            .frame(minHeight: 0.6)
                            .background(.white)
                            .padding(.vertical,25)
                    
                        Text(changeStringColor(listing.example2, targetWords: targetWords))
                            .padding(.bottom,10)
                            
                        Text(listing.translation2)
                            .padding(.bottom,10)
                         
                        Divider()
                            .frame(minHeight: 0.6)
                            .background(.white)
                            .padding(.vertical,25)
                    }
                    
                    Text(listing.normalWord)
                        .font(.title3)
                        .bold()
                    
                    Spacer()
                }
                .frame(maxWidth: 345)
                .foregroundStyle(.white)
                .navigationBarBackButtonHidden()
                .navigationDestination(isPresented: $backToTitle) { BrowseWordsView(wordsList: DeveloperPreview()) }
            }
        }
    }

#Preview {
    WordDetailView(listing: DeveloperPreview.shared.listings[47])
}
