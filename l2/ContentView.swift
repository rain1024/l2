//
//  ContentView.swift
//  l2
//
//  Created by Vu Anh on 14/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            Library()
                .tabItem(){
                    Image(systemName: "books.vertical.fill")
                    Text("Library")
                }
            ViewVocab()
                .tabItem(){
                    Image(systemName: "square.stack.3d.up.badge.a.fill")
                    Text("Vocabulary")
                }
            ViewB()
                .tabItem(){
                    Image(systemName: "plus.circle")
                    Text("Add")
                }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
