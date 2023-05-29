//
//  ViewIPATool.swift
//  l2
//
//  Created by Vu Anh on 25/05/2023.
//

import SwiftUI
import UIKit

struct ViewIPATool: View {
    
    struct PhoneticType: Hashable {
        let value: String
        let label: String
    }
    
    let types = [
        PhoneticType(value: "consonant", label: "Consonants"),
        PhoneticType(value: "semivowel", label: "Semivowels"),
        PhoneticType(value: "vowel", label: "Vowels"),
        PhoneticType(value: "nasal_vowel", label: "Nasal vowels"),
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                let gridItems = [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())]
                
                ForEach(types, id: \.self) { type in
                    Section(
                        header: Text(type.label)
                            .font(.title)
                            .padding(20)
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading)
                    ) {
                        LazyVGrid(columns: gridItems, spacing: 20) {
                            ForEach(phonetics.filter {
                                $0.type == type.value
                            }.sorted(by: { $0.order < $1.order }),
                                    id: \.self) { phonetic in
                                PhoneticItemView(phonetic: phonetic)
                            }
                        }
                        .padding(10)
                    }
                }
            }
        }
        .navigationTitle("IPA")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ViewIPATool_Previews: PreviewProvider {
    static var previews: some View {
        ViewIPATool()
    }
}
