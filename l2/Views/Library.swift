//
//  ViewC.swift
//  l2
//
//  Created by Vu Anh on 15/05/2023.
//

import SwiftUI

struct Library: View {
    var body: some View {
        NavigationView {
            List {
                Text("Chú cuội")
                Text("Quê hương")
                Text("Học đếm")
            }
            .navigationTitle("Library")
        }   
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
