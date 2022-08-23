//
//  RecordSoundView.swift
//  PitchPerfect
//
//  Created by David Koch on 19.08.22.
//

import SwiftUI
import AVFoundation
struct RecordSoundView: View {
    
    @State var audioRecorderDelegate: AVAudioRecorderDelegate!
    @State private var recordingLabel: String = "Tap to Record..."
    @State private var recording: Bool = false
    @State private var playSoundViewShown: Bool = false
    @State var filePath: URL?
    @State var audioRecorder: AVAudioRecorder!
    var body: some View {
        NavigationView {
            
            VStack{
                Button (action:{
                    recordAudio()
                }, label:{
                    Image(systemName: "mic.circle.fill").resizable().frame(width: 128, height: 128, alignment: .center)
                }).foregroundColor(.accentColor).disabled(recording)
                Text(recordingLabel)
                NavigationLink("", destination: PlaySoundView(recordedAudioURL: filePath ?? URL(fileURLWithPath: "")), isActive: $playSoundViewShown)
                Button(action: {
                    stopRecording()
                },
                       label: {
                    Image(systemName: "stop.circle.fill").resizable().frame(width: 64, height: 64, alignment: .center)
                }).foregroundColor(.accentColor).disabled(!recording)
            }
            
        }
    }
    
    func recordAudio(){
        recording = true
        recordingLabel = "Recording in Progress"
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        filePath = URL(fileURLWithPath: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(.playAndRecord, options: .defaultToSpeaker)
        try! session.setActive(true)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    func stopRecording(){
        recording = false
        recordingLabel = "Tap to Record..."
        playSoundViewShown = true
        
        audioRecorder.stop()
        print(audioRecorder.isRecording)
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RecordSoundView()
        
    }
}
