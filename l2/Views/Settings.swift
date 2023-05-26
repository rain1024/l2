//
//  Settings.swift
//  l2
//
//  Created by Vu Anh on 20/05/2023.
//

import SwiftUI
import Combine

struct Settings: View {
    @State private var learnName: String = "English"
    @State private var byName: String = "Vietnamese"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Learn Language")){
                    Picker("Learn Language", selection: $learnName){
                        ForEach(languageNames, id:\.self){
                            Text($0)
                        }
                    }.onChange(of: learnName){_ in
                        print("Change learn language:", learnName)
                        let object = languages.first(where: {$0.name == learnName})!
                        print(object)
                        UserDefaults.standard.storeObject(object, key: "learnLanguage")
                    }
                }
                Section(header: Text("By Language")){
                    Picker("By Language", selection: $byName){
                        ForEach(languageNames, id:\.self){
                            Text($0)
                        }
                    }.onChange(of: byName){_ in
                        print("Change by language:", byName)
                        let object = languages.first(where: {$0.name == byName})!
                        UserDefaults.standard.storeObject(object, key: "byLanguage")
                    }
                }
                
                Section(header: Text("Tools")) {
                    NavigationLink(destination: ViewIPATool()) {
                        Text("IPA")
                    }
                    NavigationLink(destination: ViewIPATool()) {
                        Text("Alphabet")
                    }
                }
                
            }
            .navigationTitle("Settings")
        }
        .onAppear(){
            let learnLanguage: Language = UserDefaults.standard.getObject(for: "learnLanguage") ?? Vietnamese
            learnName = learnLanguage.name
            
            let byLanguage: Language = UserDefaults.standard.getObject(for: "byLanguage") ?? Vietnamese
            byName = byLanguage.name
        }
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
