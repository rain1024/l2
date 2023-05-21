//
//  StoryDetail.swift
//  l2
//
//  Created by Vu Anh on 20/05/2023.
//

import SwiftUI

struct StoryDetail: View {
    var story: Story
    
    var body: some View {
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
    }
}

struct StoryDetail_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetail(story: stories[3])
    }
}
