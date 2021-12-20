//
//  PlayerPresenter.swift
//  PlayForMe
//
//  Created by Jade Silveira on 15/12/21.
//

import SwiftUI

final class PlayerPresenter: ObservableObject {
    private let interactor: PlayerInteractorInput
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
    
    func play() {
        interactor.play()
        isPlayButton = false
    }
    
    func pause() {
        interactor.pause()
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
