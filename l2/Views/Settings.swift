//
//  Settings.swift
//  l2
//
//  Created by Vu Anh on 20/05/2023.
//

import SwiftUI
import Combine

struct Settings: View {
    @State var displayLanguage: String = UserDefaults.standard.string(forKey: "displayLanguage") ?? "Vietnamese"
    @State private var learnLanguage: String = UserDefaults.standard.string(forKey: "learnLanguage") ?? "Vietnamese"
    
    let languages = ["Vietnamese", "English", "French", "Japanese", "Chinese"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Display Language")){
                    Picker("Display Language", selection: $displayLanguage){
                        ForEach(languages, id:\.self){
                            Text($0)
                        }
                    }.onChange(of: displayLanguage){_ in
                        print("Change display language:", displayLanguage)
                        UserDefaults.standard.set(displayLanguage, forKey: "displayLanguage")
                    }
                }
                Section(header: Text("Learn Language")){
                    Picker("Learn Language", selection: $learnLanguage){
                        ForEach(languages, id:\.self){
                            Text($0)
                        }
                    }.onChange(of: learnLanguage){_ in
                        print("Change learn language:", learnLanguage)
                        UserDefaults.standard.set(learnLanguage, forKey: "learnLanguage")
                    }
                }
            }
            .navigationTitle("Settings")
        }
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
