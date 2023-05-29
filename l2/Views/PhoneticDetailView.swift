//
//  PhoneticDetailView.swift
//  l2
//
//  Created by Vu Anh on 26/05/2023.
//

import SwiftUI

struct PhoneticDetailView: View {
    var phonetic: Phonetic
    
    @State private var soundToPlay: String?
    
    @ViewBuilder
    func PlayButton(sound: String) -> some View {
        Button {
            playSound(sound: sound, type: "mp3")
        } label: {
            Image(systemName: "speaker.3.fill")
                .resizable()
                .frame(width: 16, height: 16)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.orange)
                .padding(10)
                .background(Circle().fill(Color.white))
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.15),
                                lineWidth: 8))
                .clipShape(Circle())
        }.buttonStyle(BorderlessButtonStyle())
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(phonetic.name)
                .fontWeight(.bold)
                .font(.headline)
                .padding(20)
            Spacer()
            
            List(phonetic.examples, id: \.self) { example in
                HStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text(LocalizedStringKey("[" + example.ipa + "]"))
                            .font(.system(
                                size: 16,
                                design: .monospaced))
                        Text(example.word)
                            .foregroundColor(.blue)
                            .font(.system(size: 18))
                        Text(example.description)
                            .italic()
                    }
                    Spacer()
                    HStack {
                        PlayButton(sound: example.sound)
                        if let sound2 = example.sound2 {
                            PlayButton(sound: sound2)
                        }
                    }
                }
            }
        }.onAppear(){
            print(phonetic)
        }
        
    }
}

struct PhoneticDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneticDetailView(phonetic: SamplePhonetic)
    }
}
