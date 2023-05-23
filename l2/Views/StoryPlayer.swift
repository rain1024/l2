//
//  StoryPlayer.swift
//  l2
//
//  Created by Vu Anh on 21/05/2023.
//

import SwiftUI

import AVFoundation


struct StoryPlayer: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var story: Story
    
    @State var player: AVAudioPlayer!
    
    //    @State var isPlaying: Bool = true
    @State var isPlaying: Bool = false
    @State var widthAudioController: CGFloat = 0
    @State var x: CGFloat = 10
    @State var isDragging = false
    @State var audioSeekButtonSize: CGFloat = 15
    
    func initSound(sound: String, type: String) {
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
    
    func playSound(){
        player?.play()
    }
    
    func stopStound(){
        player?.pause()
    }
    
    var bgColor: Color = Color("DarkBackground")
    
    var body: some View {
        ZStack {
            bgColor.ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        stopStound()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text(story.title)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    Spacer()
                }
                ScrollView {
                    Text(story.text)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .lineSpacing(10)
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                        .padding(.bottom, 20)
                }
                Spacer()
                if story.audio != nil {
                    VStack {
                        HStack() {
                            ZStack(alignment: .leading){
                                Capsule()
                                    .fill(Color.gray)
                                    .frame(height:8)
                                    .background(.black)
                                Capsule()
                                    .fill(Color.red)
                                    .frame(width: widthAudioController, height:8)
                                    .background(.black)
                                Circle()
                                    .fill(Color.black)
                                    .background(.red)
                                    .frame(width: audioSeekButtonSize, height: audioSeekButtonSize)
                                    .offset(x: x)
                                    .gesture(
                                        DragGesture()
                                            .onChanged({ value in
                                                print(value)
                                                audioSeekButtonSize = 20
                                                let maxX = UIScreen.main.bounds.width - 40
                                                let minX: CGFloat = 0
                                                if(value.location.x > maxX){
                                                    x = maxX
                                                } else if(value.location.x < minX){
                                                    x = minX
                                                } else {
                                                    x = value.location.x
                                                }
                                                print(value.translation.width)
                                                isDragging = true
                                            })
                                            .onEnded({ value in
                                                audioSeekButtonSize = 15
                                                isDragging = false
                                            })
                                    )
                            }.padding(20)
                        }
                        HStack {
                            Button {
                                player.currentTime = (player.currentTime - 5 > 0) ? player.currentTime - 5 : 0
                            } label: {
                                Image(systemName: "gobackward.5")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                            }
                            
                            Button {
                                if(isPlaying){
                                    stopStound()
                                } else {
                                    playSound()
                                }
                                isPlaying.toggle()
                            } label: {
                                let buttonLabel: String = isPlaying ? "stop.circle" : "play.circle"
                                Image(systemName: buttonLabel)
                                    .font(.system(size: 60))
                                    .foregroundColor(.white)
                            }
                            
                            Button {
                                player.currentTime = (player.currentTime + 5 < player.duration) ? player.currentTime + 5 : player.duration
                            } label: {
                                Image(systemName: "goforward.5")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
        }
        .onAppear() {
            if story.audio != nil {
                //                initSound(sound: story.audio!, type: "mp3")
            }
            
            //            Timer.scheduledTimer(withTimeInterval: 1, repeats: true){
            //                (_) in
            //
            //                print(player.currentTime)
            //                let screen = UIScreen.main.bounds.width - 40
            //                let value = player.currentTime / player.duration
            //                widthAudioController = screen * CGFloat(value)
            //            }
        }
    }
}

struct StoryPlayer_Previews: PreviewProvider {
    static var previews: some View {
        let item = stories[4]
        StoryPlayer(story: item)
        //        StoryPlayer()
    }
}
