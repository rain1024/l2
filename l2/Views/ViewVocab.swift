//
//  ViewA.swift
//  l2
//
//  Created by Vu Anh on 15/05/2023.
//

import SwiftUI

struct ViewVocab: View {
    
    @State var searchText = ""
    @State private var title = "Vocab"
    
    @State private var availableVocabs: [Vocab] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(availableVocabs, id: \.text) {
                    vocab in HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack (spacing: 10) {
                                Text(vocab.text)
//                                    .border(.red)
                                Button(action: {
                                    playSound(sound: vocab.text, type: "mp3")
                                }) {
                                    Image(systemName: "speaker.wave.2.circle")
                                }
                                .buttonStyle(BorderlessButtonStyle())
                            }
//                            .border(.green)
                            
                            if vocab.description != nil {
                                HStack {
                                    Text(vocab.description!)
                                        .font(.caption)
                                }
//                                .border(.green)
                            }
                        }
//                        .border(.yellow)
                            
                        NavigationLink {
                            ViewVocabDetail(vocab: vocab)
                        } label: {
                            Text("")
                        }
                        
                    }
                    .padding(1)
                }
        
            }
            .searchable(text: $searchText)
            .navigationTitle($title)
        }.onAppear(){
            let learnLanguage: Language = UserDefaults.standard.getObject(for: "learnLanguage") ?? Vietnamese
            title = learnLanguage.flag + " Vocab"
            
            availableVocabs = vocabs.filter {
                $0.lang == learnLanguage.code
            }
        }
    }
}

struct ViewVocab_Previews: PreviewProvider {
    static var previews: some View {
        ViewVocab()
    }
}
