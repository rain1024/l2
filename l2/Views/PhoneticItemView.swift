//
//  SwiftUIView.swift
//  l2
//
//  Created by Vu Anh on 26/05/2023.
//

import SwiftUI

struct PhoneticItemView: View {
    var phonetic: Phonetic
    
    @State private var showingSheet = false
    
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
                                .stroke(Color.gray.opacity(0.15),
                                        lineWidth: 8))
                        .clipShape(Circle())
                }
            }
        }.sheet(isPresented: $showingSheet) {
            PhoneticDetailView(phonetic: phonetic)
        }.onTapGesture {
            showingSheet.toggle()
        }
    }
}

struct PhoneticItemView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneticItemView(phonetic: SamplePhonetic)
    }
}
