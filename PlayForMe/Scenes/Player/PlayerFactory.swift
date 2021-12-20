//
//  PlayerFactory.swift
//  PlayForMe
//
//  Created by Jade Silveira on 15/12/21.
//

import Foundation
import SwiftUI

enum PlayerFactory {
    static func make() -> some View {
        let interactor: PlayerInteractorInput = PlayerInteractor()
        let presenter: PlayerPresenter = PlayerPresenter(interactor: interactor)
        let view: PlayerView = PlayerView(presenter: presenter)
        
        presenter.view = view
        return view
    }
}
