//
//  ViewIPATool.swift
//  l2
//
//  Created by Vu Anh on 25/05/2023.
//

import SwiftUI
import UIKit

struct ViewIPATool: View {
    var body: some View {
        NavigationView {
            ScrollView {
                
                let gridItems = [
                    GridItem(.flexible()),
                    GridItem(.flexible()),
                    GridItem(.flexible())]
                
                LazyVGrid(columns: gridItems, spacing: 20) {
                    ForEach(phonetics, id: \.self){ phonetic in
                        PhoneticItemView(phonetic: phonetic)
                    }
                }
                .padding(10)
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
