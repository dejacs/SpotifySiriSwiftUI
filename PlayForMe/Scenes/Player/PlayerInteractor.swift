//
//  PlayerInteractor.swift
//  PlayForMe
//
//  Created by Jade Silveira on 15/12/21.
//

import Foundation

protocol PlayerInteractorInput {
    func previous()
    func play()
    func pause()
    func next()
    func enableShuffle()
    func disableShuffle()
    func enableRepeat()
    func disableRepeat()
}

final class PlayerInteractor {
    private let spotifyManager: SpotifyManagerProtocol

    init(spotifyManager: SpotifyManagerProtocol = SpotifyManager.shared) {
        self.spotifyManager = spotifyManager
    }
}

extension PlayerInteractor: PlayerInteractorInput {
    func previous() {
        spotifyManager.pause()
        spotifyManager.previous()
    }
    
    func play() {
        spotifyManager.play(uri: "")
    }
    
    func pause() {
        spotifyManager.pause()
    }
    
    func next() {
        spotifyManager.pause()
        spotifyManager.next()
    }
    
    func enableShuffle() {
        spotifyManager.enableShuffle()
    }
    
    func disableShuffle() {
        spotifyManager.disableShuffle()
    }
    
    func enableRepeat() {
        spotifyManager.enableRepeat()
    }
    
    func disableRepeat() {
        spotifyManager.disableRepeat()
    }
}
