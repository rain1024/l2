//
//  ViewC.swift
//  l2
//
//  Created by Vu Anh on 15/05/2023.
//

import SwiftUI

struct Library: View {
    
    @State var tabBarVisibility: Visibility = .visible
    
    var body: some View {
        ZStack {
            NavigationView {
                List(stories, id: \.title) { story in
                    NavigationLink {
                        StoryDetail(story: story, parentView: self)
                    } label:  {
                        HStack {
                            Text(story.title)
                        }
                    }
                }
                .navigationTitle("Library")
            }
        }.toolbar(tabBarVisibility, for: .tabBar)
            .onAppear(){
                print(vocab1)
            }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
