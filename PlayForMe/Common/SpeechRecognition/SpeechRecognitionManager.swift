//
//  SpeechRecognitionManager.swift
//  Banho
//
//  Created by Jade Silveira on 10/12/21.
//

import Foundation
import Speech

final class SpeechRecognitionManager {
    static let shared = SpeechRecognitionManager()
    
    private let audioManager = AVAudioManager.shared
    
    private var dictatedSpeech: String = ""
    
    func start() {
        let recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        recognitionRequest.shouldReportPartialResults = true
        
        audioManager.configureMicrophone()
        audioManager.configureRecord { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            recognitionRequest.append(buffer)
        }
        audioManager.startRecording()
        
        var timer: Timer?
        
        let speechRecognizer = SFSpeechRecognizer()
        _ = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
            self.dictatedSpeech = result?.bestTranscription.formattedString.lowercased() ?? ""
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.didFinishTalk), userInfo: nil, repeats: false)
        }
    }
}

private extension SpeechRecognitionManager {
    @objc func didFinishTalk() {
        guard dictatedSpeech != "" else { return }
        audioManager.stopRecording()
        SpotifyManager.shared.play(uri: dictatedSpeech)
    }
}
