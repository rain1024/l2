//
//  Word.swift
//  l2
//
//  Created by Vu Anh on 20/05/2023.
//

import SwiftUI

struct ViewVocabDetail: View {
    var vocab: Vocab
    
    func getSearchURL() -> String {
        var url: String = "https://youtube.com/results?search_query="
        let normalizeText = vocab.text
            .addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
            .replacingOccurrences(of: " ", with: "+")
        let learnLanguage: Language = UserDefaults.standard.getObject(for: "learnLanguage")!
        
        url += normalizeText + "+pronunciation+in+" + learnLanguage.name
        return url
    }
    
    var body: some View {
        
        VStack (alignment: .leading) {
            HStack {
                Text(vocab.text)
                    .font(.title)
                
                Button(action: {
                    playSound(sound: vocab.text, type: "mp3")
                }) {
                    Image(systemName: "speaker.wave.2.circle")
                }
                .buttonStyle(BorderlessButtonStyle())
                
                Spacer()
            }
            .padding()
            
            
            HStack {
                if vocab.description != nil {
                    Text(vocab.description!)
                } else {
                    Text("")
                }
                Spacer()
            }
            .padding()
            
            HStack {
                Link(
                    destination: URL(string: getSearchURL())!,
                    label: {
                        Label("Guide to Pronunciation", systemImage: "mouth")
                    })
            }
            .padding()
            
            Spacer()
        }
    }
}

struct ViewVocabDetail_Previews: PreviewProvider {
    static var previews: some View {
        let vocab = Vocab(
            text: "xin chào",
            lang: "vi",
            description: "chào hỏi trang trọng"
        )
        ViewVocabDetail(vocab: vocab)
    }
}
