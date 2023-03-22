//
//  PlayForMeApp.swift
//  PlayForMe
//
//  Created by Jade Silveira on 11/12/21.
//

import SwiftUI

@main
struct PlayForMeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            TabContentView()
                .onOpenURL(perform: didOpenURL)
                .onContinueUserActivity(ShortcutType.play.rawValue, perform: play)
                .onContinueUserActivity(ShortcutType.pause.rawValue, perform: pause)
                .onContinueUserActivity(ShortcutType.next.rawValue, perform: next)
                .onContinueUserActivity(ShortcutType.previous.rawValue, perform: previous)
                .onContinueUserActivity(ShortcutType.playlist.rawValue, perform: playlist)
                .onContinueUserActivity(ShortcutType.shuffle.rawValue, perform: shuffle)
        }
    }
    
    func didOpenURL(_ url: URL) {
        SpotifyManager.shared.openedUrl(application: UIApplication.shared, url: url)
    }
    
    func play(activity: NSUserActivity) {
        SpotifyManager.shared.play(uri: "4qUQtsemTJFpO432Qfpx1x?si=ShjSl0GITGKlu3p-tLLfBg")
        SpotifyManager.shared.resume()
//        SpotifyConnect.shared.play()
    }
    
    func pause(activity: NSUserActivity) {
        SpotifyManager.shared.pause()
//        SpotifyConnect.shared.pause()
    }
    
    func next(activity: NSUserActivity) {
//        SpotifyConnect.shared.pause()
//        SpotifyConnect.shared.next()
    }
    
    func previous(activity: NSUserActivity) {
//        SpotifyConnect.shared.pause()
//        SpotifyConnect.shared.previous()
    }
    
    func playlist(activity: NSUserActivity) {
//        SpeechRecognitionManager.shared.start()
    }
    
    func shuffle(activity: NSUserActivity) {
//        SpotifyConnect.shared.enableShuffle()
    }
}
