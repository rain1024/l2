//
//  ViewA.swift
//  l2
//
//  Created by Vu Anh on 15/05/2023.
//

import SwiftUI
import AVFoundation

var player: AVAudioPlayer!

struct ViewVocab: View {
    
    @State var searchText = ""
    
    let words = [
        "xin chào",
        "tạm biệt",
        "cảm ơn",
        "không có gì",
        "vui",
        "buồn",
        "đúng",
        "sai",
        "tốt",
        "xấu"
    ]
    
    
    
    func playSound(sound: String, type: String) {
        let url = Bundle.main.url(forResource: sound, withExtension: type)
        guard url != nil else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player?.play()
        } catch {
            print("\(error)")
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(words, id: \.self) {
                    word in HStack {
                        Text(word)
                        Button(action: {
                            playSound(sound: word, type: "mp3")
                        }) {
                            Image(systemName: "speaker.wave.2.circle")
                        } .buttonStyle(BorderlessButtonStyle())
                        Spacer()
                        NavigationLink {
                            Word()
                        } label: {
                            Text("")
                        }
                        
                    }
                    .padding(3)
                }
        
            }
            .searchable(text: $searchText)
            .navigationTitle("Vocab")
        }
    }
}

struct ViewVocab_Previews: PreviewProvider {
    static var previews: some View {
        ViewVocab()
    }
}
