//
//  PlayerPresenter.swift
//  PlayForMe
//
//  Created by Jade Silveira on 15/12/21.
//

import SwiftUI

protocol PlayerPresenterDelegate: AnyObject {
    func updateViewConnectedState()
    func updateViewDisconnectedState()
    func updateImage(_ image: UIImage?)
}

final class PlayerPresenter: ObservableObject {
    private let interactor: PlayerInteractorInput
    private let spotifyManager: SpotifyManagerProtocol = SpotifyManager.shared
    
    var view: PlayerViewOutput?
    
    @Published var isPlayButton: Bool = false
    @Published var isShuffleEnable: Bool = false
    @Published var isRepeatEnable: Bool = false
    
    init(interactor: PlayerInteractorInput) {
        self.interactor = interactor
    }
    
    func enablePlayButton() -> some View {
        isPlayButton ? view?.enabledPlayButton() : view?.disabledPlayButton()
    }
    
    func enableShuffleButton() -> some View {
        isShuffleEnable ? view?.enabledShuffleButton() : view?.disabledShuffleButton()
    }
    
    func enableRepeatButton() -> some View {
        isRepeatEnable ? view?.enabledRepeatButton() : view?.disabledRepeatButton()
    }
    
    func connect() {
        spotifyManager.connect()
    }
    
    func disconnect() {
        spotifyManager.disconnect()
    }
    
    func play() {
        spotifyManager.resume()
        isPlayButton = false
    }
    
    func pause() {
        spotifyManager.pause()
        isPlayButton = true
    }
    
    func enableShuffle() {
        interactor.enableShuffle()
        isShuffleEnable = true
    }
    
    func disableShuffle() {
        interactor.disableShuffle()
        isShuffleEnable = false
    }
    
    func enableRepeat() {
        interactor.enableRepeat()
        isRepeatEnable = true
    }
    
    func disableRepeat() {
        interactor.disableRepeat()
        isRepeatEnable = false
    }
    
    func previous() {
        interactor.previous()
    }
    
    func next() {
        interactor.next()
    }
}

extension PlayerPresenter: PlayerPresenterDelegate {
    func updateViewConnectedState() {
//        connectButton.isHidden = true
//        disconnectButton.isHidden = false
//        connectLabel.isHidden = true
//        imageView.isHidden = false
//        trackLabel.isHidden = false
//        pauseAndPlayButton.isHidden = false
    }
    
    func updateViewDisconnectedState() {
        
    }
    
    func updateImage(_ image: UIImage?) {
        
    }
}
