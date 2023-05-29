//
//  ConversationView.swift
//  l2
//
//  Created by Vu Anh on 28/05/2023.
//

import SwiftUI
import AVFoundation
import Speech

struct Conversation: Identifiable {
    let id = UUID()
    let text: String
    let translation: String
    let ipa: String
    let sound: String
}

enum Mode {
    case rolePlaying
    case passive
}

struct ConversationItemView: View {
    let conversation: Conversation
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(conversation.text)
                    .font(.headline)
                Text(conversation.translation)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(conversation.ipa)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Button(action: {
                // Play the sound
                // Implement your sound playback logic here
            }) {
                Image(systemName: "play.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            }
            
            Button(action: {
                // Handle record button action
            }) {
                Image(systemName: "mic.fill")
                    .font(.title)
                    .padding()
                    .background(Color.primary.opacity(0.1))
                    .clipShape(Circle())
            }
        }
        .padding(.vertical)
    }
}


struct ConversationView: View {
    @State private var isRecording = false
    @State private var recordedText = ""
    @State private var mode: Mode = .rolePlaying
    @State private var selectedConversationIndex = 0
    @State private var translationWidth: CGFloat = 0
    @State private var offset: CGFloat = 0
    @State private var timer: Timer?
    @State private var isPopoverPresented = false
    
    let audioRecorder: AudioRecorder
    
    let conversations = [
        Conversation(text: "Bonjour", translation: "Hello", ipa: "/bɔ̃.ʒuʁ/", sound: "hello_sound.mp3"),
        Conversation(text: "Au revoir", translation: "Goodbye", ipa: "/o ʁə.vwaʁ/", sound: "goodbye_sound.mp3"),
        Conversation(text: "Merci", translation: "Thank you", ipa: "/mɛʁ.si/", sound: "thankyou_sound.mp3"),
        Conversation(text: "Pardon", translation: "Sorry", ipa: "/paʁ.dɔ̃/", sound: "sorry_sound.mp3"),
        Conversation(text: "Oui", translation: "Yes", ipa: "/wi/", sound: "yes_sound.mp3"),
        Conversation(text: "Non", translation: "No", ipa: "/nɔ̃/", sound: "no_sound.mp3")
    ]
    
    
    init() {
        self.audioRecorder = AudioRecorder()
    }
    
    var body: some View {
        
        NavigationView {
            ScrollView(showsIndicators: false) {
                if mode == .rolePlaying {
                    VStack {
                        ScrollView {
                            ConversationItemView(conversation: conversations[selectedConversationIndex])
                        }
                        
                        Button(action: {
                            selectedConversationIndex = (selectedConversationIndex + 1) % conversations.count
                        }) {
                            Text("Change Conversation")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .animation(.interpolatingSpring(stiffness: 100, damping: 10))
                    .frame(height: UIScreen.main.bounds.height * 0.7)
                    .offset(x: translationWidth + offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                translationWidth = gesture.translation.width
                            }
                            .onEnded { gesture in
                                withAnimation(.interpolatingSpring(stiffness: 100, damping: 10)) {
                                    if translationWidth < -100 {
                                        selectedConversationIndex = (selectedConversationIndex + 1) % conversations.count
                                    } else if translationWidth > 100 {
                                        selectedConversationIndex = (selectedConversationIndex + conversations.count - 1) % conversations.count
                                    }
                                    translationWidth = 0
                                    offset = 0
                                }
                            }
                            .simultaneously(with:
                                                DragGesture()
                                .onChanged { gesture in
                                    offset = gesture.translation.width
                                }
                                .onEnded { gesture in
                                    withAnimation(.interpolatingSpring(stiffness: 100, damping: 10)) {
                                        offset = 0
                                    }
                                }
                                           )
                    )
                    
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(conversations) { conversation in
                                ConversationItemView(conversation: conversation)
                            }
                        }
                    }
                    .padding()
                }
                
                VStack {
                    Text(recordedText)
                    
                    Button(action: {
                        print("Voice record button tapped!")
                        
                        if isRecording {
                            audioRecorder.stopRecording { recognizedText in
                                recordedText = recognizedText
                            }
                        } else {
                            audioRecorder.startRecording()
                            
                        }
                        isRecording.toggle()
                    }) {
                        Image(systemName: "mic.fill")
                            .font(.title)
                            .padding()
                            .background(Color.primary.opacity(0.1))
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.blue, lineWidth: 1)
                                    .scaleEffect(isRecording ? 1.5 : 1)
                                    .opacity(isRecording ? 0 : 1)
                                    .animation(isRecording ? Animation.easeOut(duration: 1).repeatForever(autoreverses: true) : .default)
                            )
                        
                    }
                    
                    Text(isRecording ? "Stop Recording" : "Start Recording")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
            }
        }
        .padding()
        .navigationBarTitle("Conversation")
        .toolbar {
            Button(action: {
                isPopoverPresented = true
            }) {
                HStack {
                    Image(systemName: mode == Mode.rolePlaying ? "person.wave.2.fill" : "ear.fill")
                        .imageScale(.small)
                    Text(mode == Mode.rolePlaying ? "Talk" : "Listen")
                }
            }
            .popover(isPresented: $isPopoverPresented) {
                VStack {
                    Form {
                        Section(header: Text("Mode")) {
                            Picker("Select Mode", selection: $mode) {
                                Text("🗣 Talk").tag(Mode.rolePlaying)
                                Text("👂 Listen").tag(Mode.passive)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                }
            }
        }
        
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView()
    }
}

class AudioRecorder: NSObject, ObservableObject {
    var audioRecorder: AVAudioRecorder!
    var isRecording = false
    
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            
            let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let audioFilename = documentPath.appendingPathComponent("recording.m4a")
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()
            
            isRecording = true
        } catch let error {
            print("Could not start recording: \(error.localizedDescription)")
        }
    }
    
    func stopRecording(completion: @escaping (String) -> Void) {
        audioRecorder.stop()
        isRecording = false
        
        let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "fr-FR"))
        let request = SFSpeechURLRecognitionRequest(url: audioRecorder.url)
        
        recognizer?.recognitionTask(with: request) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Recognition error: \(error.localizedDescription)")
                completion("")
            } else if let result = result {
                let recognizedText = result.bestTranscription.formattedString
                completion(recognizedText)
            }
            
            // Reset the audio session
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setActive(false)
            } catch let error {
                print("Could not deactivate audio session: \(error.localizedDescription)")
            }
            
            // Clean up the audio file
            do {
                try FileManager.default.removeItem(at: self.audioRecorder.url)
            } catch let error {
                print("Could not remove audio file: \(error.localizedDescription)")
            }
        }
    }
}
