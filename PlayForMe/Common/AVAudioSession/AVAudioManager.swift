//
//  AVAudioManager.swift
//  PlayForMe
//
//  Created by Jade Silveira on 16/12/21.
//

import AVFoundation

final class AVAudioManager {
    static let shared = AVAudioManager()
    
    private let audioSession = AVAudioSession.sharedInstance()
    private let audioEngine = AVAudioEngine()
    
    func configureSpeaker() {
        do {
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deactivateSpeaker() {
        do {
            try audioSession.setActive(false)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func configureMicrophone() {
        do {
            try audioSession.setCategory(.record, mode: .measurement, options: [.duckOthers])
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func configureRecord(completion: @escaping AVAudioNodeTapBlock) {
        let recordingFormat = audioEngine.inputNode.outputFormat(forBus: .zero)
        
        audioEngine.inputNode.installTap(onBus: .zero, bufferSize: 1024, format: recordingFormat, block: completion)
        audioEngine.prepare()
    }
    
    func startRecording() {
        do {
            try audioEngine.start()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func stopRecording() {
        audioEngine.inputNode.removeTap(onBus: 0)
        audioEngine.stop()
    }
}
