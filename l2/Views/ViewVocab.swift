//
//  ViewA.swift
//  l2
//
//  Created by Vu Anh on 15/05/2023.
//

import SwiftUI

struct ButtonTab: View {
    @Binding var topic: String
    @State var label: String
    
    var body: some View {
        if (topic == label) {
            Button {
                topic = label
            } label: {
                Text(label)
                    .foregroundColor(Color("ButtonGrayTextSelect"))
                    .textCase(.none)
                    .padding(10)
            }
            .background(Color("ButtonGraySelect"))
            .cornerRadius(10)
        } else {
            Button {
                topic = label
            } label: {
                Text(label)
                    .foregroundColor(Color("ButtonGrayText"))
                    .textCase(.none)
                    .padding(10)
            }
            .background(Color("ButtonGray"))
            .cornerRadius(10)
        }
        
    }
}

struct ListHeader: View {
    @Binding var topic: String
    
    let topics = [
        "All",
        "Greetings",
        "Family",
        "Emotions",
        "Date time",
        "Numbers",
        "Works",
        "Hobbies"
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack() {
                ForEach(topics, id: \.self){eachTopic in
                    ButtonTab(
                        topic: $topic,
                        label: eachTopic)
                }
            }
        }.padding(.bottom)
            .onAppear(){
                topic = "All"
            }
    }
}

struct ViewVocab: View {
    
    @State var searchText = ""
    @State private var title = "Vocab"
    @State private var topic = "All"
    @State private var learnLanguage = Vietnamese
    
    @State private var availableVocabs: [Vocab] = []
    
    var body: some View {
        
        
        NavigationView {
            
            List {
                Section(header: ListHeader(topic: $topic)) {
                    ForEach(vocabs.filter {
                        $0.lang == learnLanguage.code
                    }.filter {
                        (topic == "All") || (
                            ($0.topic != nil) && ($0.topic! == topic)
                        )
                    }, id: \.text) {
                        vocab in HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(vocab.text)
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
                                    //.border(.green)
                                }
                            }
                            //.border(.yellow)
                            
                            NavigationLink {
                                ViewVocabDetail(vocab: vocab)
                            } label: {
                                Text("")
                            }
                        }
                        .padding(16)
                    }
                }.listRowInsets(EdgeInsets())
            }
            .navigationTitle($title)
            
        }.onAppear(){
            learnLanguage = UserDefaults.standard.getObject(for: "learnLanguage") ?? Vietnamese
            title = learnLanguage.flag + " Vocab"
        }
    }
}

struct ViewVocab_Previews: PreviewProvider {
    static var previews: some View {
        ViewVocab()
    }
}
