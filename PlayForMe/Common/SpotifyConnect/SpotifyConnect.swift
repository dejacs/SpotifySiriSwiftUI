//
//  SpotifyConnect.swift
//  PlayForMe
//
//  Created by Jade Silveira on 11/12/21.
//

import Foundation

protocol SpotifyConnecting {
    func play()
    func pause()
    func next()
    func previous()
    func enableShuffle()
    func disableShuffle()
    func enableRepeat()
    func disableRepeat()
}

final class SpotifyConnect: NSObject {
    static let shared = SpotifyConnect()
    
    private let redirectURL = "[ YOUR REDIRECT URL ]"
    private let clientID = "[ YOUR CLIENT ID ]"
    private var auth = SPTAuth.defaultInstance()
    
    private lazy var player: SPTAudioStreamingController? = {
        let player = SPTAudioStreamingController.sharedInstance()
        player?.playbackDelegate = self
        player?.delegate = self
        return player
    }()
    private var currentTrack: SPTPlaybackTrack?
    private var playlists = [SPTPartialPlaylist]()
    private var lastPlayedURI = ""
    
    func setup() {
        auth?.redirectURL = URL(string: redirectURL)
        auth?.clientID = clientID
        auth?.requestedScopes = [SPTAuthStreamingScope,
                                 SPTAuthPlaylistReadPrivateScope,
                                 SPTAuthPlaylistReadCollaborativeScope,
                                 SPTAuthUserLibraryReadScope,
                                 SPTAuthUserLibraryModifyScope]
        
        if let url = auth?.spotifyAppAuthenticationURL() {
            UIApplication.shared.open(url)
        }
    }
    
    func onOpen(url: URL) {
        guard let canHandleURL = auth?.canHandle(auth?.redirectURL), canHandleURL else { return }
        auth?.handleAuthCallback(withTriggeredAuthURL: url, callback: { _,_  in
            do {
                try self.player?.start(withClientId: self.auth?.clientID)
                self.player?.login(withAccessToken: self.auth?.session?.accessToken)
            } catch {
                print(error.localizedDescription)
            }
        })
    }
}

extension SpotifyConnect: SPTAudioStreamingPlaybackDelegate {
    func audioStreaming(_ audioStreaming: SPTAudioStreamingController, didChange metadata: SPTPlaybackMetadata) {
        currentTrack = audioStreaming.metadata.currentTrack
        lastPlayedURI = audioStreaming.metadata.currentTrack?.uri ?? ""
        NowPlayingManager.shared.setupNowPlaying(audioStreaming: audioStreaming)
    }
}

extension SpotifyConnect: SPTAudioStreamingDelegate {
    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController) {
        fetchUserPlaylists()
    }
}

extension SpotifyConnect: SpotifyConnecting {
    func start(playlist: String) {
        let playableUri = playlists.first { $0.name.lowercased().contains(playlist) }?.playableUri.absoluteString ?? ""
        play(uri: playableUri)
    }
    
    func play(uri: String = "") {
        guard let isLoggedIn = player?.loggedIn, isLoggedIn, !uri.elementsEqual(lastPlayedURI) else {
            setup()
            return
        }
        lastPlayedURI = uri
        
        AVAudioManager.shared.configureSpeaker()
        player?.playSpotifyURI(uri, startingWith: .zero, startingWithPosition: .zero, callback: { (error) in
            guard error == nil else { return }
        })
    }
    
    func play() {
        guard let isLoggedIn = player?.loggedIn, isLoggedIn else {
            setup()
            return
        }
        AVAudioManager.shared.configureSpeaker()
        player?.setIsPlaying(true) { error in
            guard error == nil else { return }
        }
    }
    
    func pause() {
        guard let isLoggedIn = player?.loggedIn, isLoggedIn else {
            setup()
            return
        }
        player?.setIsPlaying(false) { error in
            guard error == nil else { return }
            AVAudioManager.shared.deactivateSpeaker()
        }
    }
    
    func next() {
        guard let isLoggedIn = player?.loggedIn, isLoggedIn else {
            setup()
            return
        }
        AVAudioManager.shared.configureSpeaker()
        player?.skipNext { error in
            guard error == nil else { return }
            self.play()
        }
    }
    
    func previous() {
        guard let isLoggedIn = player?.loggedIn, isLoggedIn else {
            setup()
            return
        }
        AVAudioManager.shared.configureSpeaker()
        player?.skipPrevious { error in
            guard error == nil else { return }
            self.play()
        }
    }
    
    func enableShuffle() {
        guard let isLoggedIn = player?.loggedIn, isLoggedIn else {
            setup()
            return
        }
        player?.setShuffle(true, callback: { error in
            guard error == nil else { return }
        })
    }
    
    func disableShuffle() {
        guard let isLoggedIn = player?.loggedIn, isLoggedIn else {
            setup()
            return
        }
        player?.setShuffle(false, callback: { error in
            guard error == nil else { return }
        })
    }
    
    func enableRepeat() {
        guard let isLoggedIn = player?.loggedIn, isLoggedIn else {
            setup()
            return
        }
        player?.setRepeat(.one, callback: { error in
            guard error == nil else { return }
        })
    }
    
    func disableRepeat() {
        guard let isLoggedIn = player?.loggedIn, isLoggedIn else {
            setup()
            return
        }
        player?.setRepeat(.off, callback: { error in
            guard error == nil else { return }
        })
    }
}

extension SpotifyConnect {
    func fetchUserPlaylists() {
        SPTPlaylistList.playlists(forUser: auth?.session?.canonicalUsername, withAccessToken: auth?.session?.accessToken, callback: { (error, response) in
            if let listPage = response as? SPTPlaylistList,
                let playlists = listPage.items as? [SPTPartialPlaylist] {
                self.playlists = playlists
            }
        })
    }
}
