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
            List(stories, id: \.title) { story in
                NavigationLink {
                    StoryDetail(story: story)
                } label:  {
                    HStack {
                        Text(story.title)
                    }
                }
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
