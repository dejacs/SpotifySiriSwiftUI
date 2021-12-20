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
    private let spotifyConnect: SpotifyConnecting
    
    init(spotifyConnect: SpotifyConnecting = SpotifyConnect.shared) {
        self.spotifyConnect = spotifyConnect
    }
}

extension PlayerInteractor: PlayerInteractorInput {
    func previous() {
        spotifyConnect.pause()
        spotifyConnect.previous()
    }
    
    func play() {
        spotifyConnect.play()
    }
    
    func pause() {
        spotifyConnect.pause()
    }
    
    func next() {
        spotifyConnect.pause()
        spotifyConnect.next()
    }
    
    func enableShuffle() {
        spotifyConnect.enableShuffle()
    }
    
    func disableShuffle() {
        spotifyConnect.disableShuffle()
    }
    
    func enableRepeat() {
        spotifyConnect.enableRepeat()
    }
    
    func disableRepeat() {
        spotifyConnect.disableRepeat()
    }
}
