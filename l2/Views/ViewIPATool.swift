//
//  ViewIPATool.swift
//  l2
//
//  Created by Vu Anh on 25/05/2023.
//

import SwiftUI
import UIKit

struct PhoneticView: View {
    var phonetic: Phonetic
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 120, height: 120)
                .foregroundColor(.white)
                .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 10)
            
            VStack {
                Text(phonetic.symbol)
                    .foregroundColor(.black)
                    .font(.system(size: 30, weight: .bold))
                Button {
                    playSound(sound: phonetic.sound, type: "mp3")
                } label: {
                    Image(systemName: "speaker.3.fill")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .foregroundColor(.orange)
                        .padding(10)
                        .background(Circle().fill(Color.white))
                        .overlay(
                            Circle()
                                .stroke(Color.gray.opacity(0.4),
                            lineWidth: 1))
                        .clipShape(Circle())
                }
                
            }
        }
    }
}

struct ViewIPATool: View {
    var body: some View {
        ScrollView {
            let gridItems = [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())]
            
//            let phonetics = [
//                "ɲ",
//                "ŋ",
//                "p",
//                "ʁ",
//                "s",
//                "ʃ",
//                "t",
//                "v",
//                "z",
//                "ʒ",
//                "j",
//                "w",
//                "ɥ",
//                "a",
//                "ɑ",
//                "e",
//                "ɛ",
//                "ɛː",
//                "ə",
//                "i",
//                "œ",
//                "ø",
//                "ɔ",
//                "u",
//                "y",
//                "ɑ̃",
//                "ɛ̃",
//                "œ̃",
//                "ɔ̃"
//            ]
            LazyVGrid(columns: gridItems, spacing: 20) {
                //                  ForEach(0..<20) { index in
                //                      PhoneticView(text: "Text \(index + 1)")
                //                  }
                ForEach(phonetics, id: \.self){ phonetic in
                    PhoneticView(phonetic: phonetic)
                }
            }
            .padding(10)
        }.navigationTitle("IPA")
        
    }
}

struct ViewIPATool_Previews: PreviewProvider {
    static var previews: some View {
        ViewIPATool()
    }
}
