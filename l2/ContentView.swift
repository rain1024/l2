//
//  ContentView.swift
//  l2
//
//  Created by Vu Anh on 14/05/2023.
//
import SwiftUI
import AVFoundation

var player: AVAudioPlayer!

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

struct ContentView: View {
    
    var body: some View {
        NavigationView {
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
    //            ViewB()
    //                .tabItem(){
    //                    Image(systemName: "plus.circle")
    //                    Text("Add")
    //                }
                Settings()
                    .tabItem(){
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
