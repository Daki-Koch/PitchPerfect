//
//  PlaySoundView.swift
//  PitchPerfect
//
//  Created by David Koch on 21.08.22.
//

import SwiftUI
import AVFoundation

struct PlaySoundView: View {
    
    @State var recordedAudioURL: URL
    @State var audioFile: AVAudioFile!
    @State var audioEngine: AVAudioEngine!
    @State var audioPlayerNode: AVAudioPlayerNode!
    @State var stopTimer: Timer!

    @State var playing: Bool = false

    enum ButtonType: Int{case slow = 0, fast, chipmunk, vader, echo, reverb}
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action:{
                    playSoundForButton(ButtonType.slow)
                }, label:{
                    Image("Slow")
                }).disabled(playing)
                Spacer()
                Button(action:{
                    playSoundForButton(ButtonType.fast)
                    
                }, label:{
                    Image("Fast")
                }).disabled(playing)
                Spacer()
            }
            Spacer()
            HStack{
                Spacer()
                Button(action:{
                    playSoundForButton(ButtonType.chipmunk)
                    
                }, label:{
                    Image("HighPitch")
                }).disabled(playing)
                Spacer()
                Button(action:{
                    playSoundForButton(ButtonType.vader)
                    
                }, label:{
                    Image("LowPitch")
                }).disabled(playing)
                Spacer()
            }
            Spacer()
            HStack{
                Spacer()
                Button(action:{
                    playSoundForButton(ButtonType.echo)
                    
                }, label:{
                    Image("Echo")
                }).disabled(playing)
                Spacer()
                Button(action:{
                    playSoundForButton(ButtonType.reverb)
                    
                }, label:{
                    Image("Reverb")
                }).disabled(playing)
                Spacer()
            }
            Spacer()
            Button(action: {
                stopButtonPressed()
            },
                   label: {
                Image(systemName: "stop.circle.fill").resizable().frame(width: 64, height: 64, alignment: .center)
            }).foregroundColor(.accentColor).disabled(!playing)
        }.onAppear {
            setupAudio()
        }
    }
    
}
