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
                .onContinueUserActivity(ShortcutType.enableShuffle.rawValue, perform: enableShuffle)
                .onContinueUserActivity(ShortcutType.disableShuffle.rawValue, perform: disableShuffle)
        }
    }
    
    func didOpenURL(_ url: URL) {
        SpotifyManager.shared.openedUrl(application: UIApplication.shared, url: url)
    }
    
    func play(activity: NSUserActivity) {
        SpotifyManager.shared.play(uri: "4qUQtsemTJFpO432Qfpx1x?si=ShjSl0GITGKlu3p-tLLfBg")
        SpotifyManager.shared.resume()
    }
    
    func pause(activity: NSUserActivity) {
        SpotifyManager.shared.pause()
    }
    
    func next(activity: NSUserActivity) {
        SpotifyManager.shared.pause()
        SpotifyManager.shared.next()
    }
    
    func previous(activity: NSUserActivity) {
        SpotifyManager.shared.pause()
        SpotifyManager.shared.previous()
    }
    
    func playlist(activity: NSUserActivity) {
        SpeechRecognitionManager.shared.start()
    }
    
    func enableShuffle(activity: NSUserActivity) {
        SpotifyManager.shared.enableShuffle()
    }
    
    func disableShuffle(activity: NSUserActivity) {
        SpotifyManager.shared.disableShuffle()
    }
    
    func enableRepeat(activity: NSUserActivity) {
        SpotifyManager.shared.enableRepeat()
    }
    
    func disableRepeat(activity: NSUserActivity) {
        SpotifyManager.shared.disableRepeat()
    }
}
