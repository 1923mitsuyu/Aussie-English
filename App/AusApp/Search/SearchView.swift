//
//  SearchView.swift
//  AusApp
//
//  Created by 三露郁史 on 17/1/2024.
//

import SwiftUI

struct SearchView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel : SearchedWordsObject
    @Binding var lookForWord : Bool
    @State var backToTitle = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("image1")
                    .opacity(0.9)
                
                ScrollView {
                    VStack {
                        HStack {
                            Button(action: {
                                // Remove the sheet
                                dismiss()
                            }) {
                                Text("Back")
                                    .foregroundStyle(.white)
                                    .fontWeight(.semibold)
                                    .bold()
                                    .padding(.top,230)
                                    .padding(.bottom,10)
                                    .padding(.trailing,300)
                            }
                        }
                        if lookForWord {
                            VStack(spacing: 10) {
                                ForEach(viewModel.listings) { listing in
                                    HStack {
                                        // Display each property in the list
                                        Text("\(listing.wordID)")
                                            .foregroundStyle(.black)
                                            .frame(width: 30, height: 30)
                                            .background(.gray)
                                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                            .padding(.horizontal,10)
                                        
                                        Text("\(listing.word)  :  \(listing.meaning1)")
                                            .fontWeight(.semibold)
                                            .frame(width: 250, alignment: .leading)
                                        Spacer()
                                    }
                                }
                                .foregroundStyle(.black)
                                .frame(width: 350, height: 50)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }
                    .padding(.bottom,248)
                    Spacer()
                }
            }
            
        }
    }
}

    
#Preview {
    SearchView(viewModel: SearchedWordsObject(service: ExploreService()), lookForWord: .constant(true))
}
    

