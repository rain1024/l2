//
//  StoryDetail.swift
//  l2
//
//  Created by Vu Anh on 20/05/2023.
//

import SwiftUI

struct StoryDetail: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var story: Story
    
    var parentView: Library
    
    @State var isPresented = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    Text(story.title)
                        .font(.largeTitle)
                        .padding(.bottom)
                    
                    Text(story.text)
                        .frame(alignment: .topLeading)
                        .font(.body)
                        .padding(.leading)
                        .padding(.trailing)
                        .padding(.bottom)
                        .lineSpacing(15)
                    Spacer()
                }
            }
            Spacer()
            if story.audio != nil {
                HStack{
                    Button {
                        isPresented = true
                    } label: {
                        Image(systemName: "headphones.circle")
                            .font(.system(size: 36))
                            .foregroundColor(.blue)
                            .padding()
                    }
                    .fullScreenCover(isPresented: $isPresented, content: {
                        StoryPlayer(story: story)
                    })
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarLeading){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                })
            }
        })
        .onAppear {
            parentView.tabBarVisibility = .hidden
        }
        .onDisappear {
            parentView.tabBarVisibility = .visible
        }
        
    }
}

struct StoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetail(story: stories[3], parentView: Library())
    }
}
