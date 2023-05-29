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
        
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    HStack {
                        Text("Stories")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                    }
                    
                    VStack {
                        ForEach(stories, id: \.title) { story in
                            HStack {
                                NavigationLink {
                                    StoryDetail(story: story, parentView: self)
                                } label:  {
                                    HStack {
                                        Label(story.title, systemImage: "book.fill")
                                            .font(.title3)
                                            .padding()
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                }
                            }
                            .overlay(
                                Divider()
                                    .background(Color.primary.opacity(0.2)),
                                alignment: .bottom
                            )
                        }
                    }.padding(.horizontal)
                    
                }
                
                VStack {
                    Text("Conversation")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    ForEach([1, 2, 3], id: \.self) { item in
                        NavigationLink {
                            ConversationView()
                        } label: {
                            Text("abc")
                        }
                    }
                }
            }
            .navigationTitle("Library")
            .navigationBarTitleDisplayMode(.inline)
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
