//
//  ViewB.swift
//  l2
//
//  Created by Vu Anh on 15/05/2023.
//

import SwiftUI

struct ViewB: View {
    @State var text: String = ""
    @State var moveToViewC = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $text)                
            }
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading){
                    Button {
                        print("Import tab")
                        moveToViewC = true
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
        }
        
    }
}

struct ViewB_Previews: PreviewProvider {
    static var previews: some View {
        ViewB()
    }
}
