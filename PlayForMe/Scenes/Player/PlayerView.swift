//
//  PlayerView.swift
//  PlayForMe
//
//  Created by Jade Silveira on 15/12/21.
//

import SwiftUI

protocol PlayerViewOutput {
    func enabledPlayButton() -> AnyView
    func disabledPlayButton() -> AnyView
    func enabledShuffleButton() -> AnyView
    func disabledShuffleButton() -> AnyView
    func enabledRepeatButton() -> AnyView
    func disabledRepeatButton() -> AnyView
}

private enum Layout {
    enum PreviousButton {
        static let imageName = "backward.end.fill"
    }
    enum PlayButton {
        static let imageName = "play.circle.fill"
    }
    enum PauseButton {
        static let imageName = "pause.circle.fill"
    }
    enum NextButton {
        static let imageName = "forward.end.fill"
    }
    enum EnabledShuffleButton {
        static let imageName = "shuffle.circle.fill"
    }
    enum DisabledShuffleButton {
        static let imageName = "shuffle"
    }
    enum EnabledRepeatButton {
        static let imageName = "repeat.circle.fill"
    }
    enum DisabledRepeatButton {
        static let imageName = "repeat"
    }
}

struct PlayerView: View {
    @ObservedObject var presenter: PlayerPresenter
    
    var body: some View {
        HStack {
            presenter.enableShuffleButton()
            previousButton()
            presenter.enablePlayButton()
            nextButton()
            presenter.enableRepeatButton()
        }
    }
}

private extension PlayerView {
    func previousButton() -> AnyView {
        let buttonViewModel = ButtonViewModel(action: presenter.previous,
                                              systemImageName: Layout.PreviousButton.imageName,
                                                      size: ButtonSize.secondary,
                                              padding: 8)
        return AnyView(ButtonView(viewModel: buttonViewModel))
    }
    
    func nextButton() -> AnyView {
        let buttonViewModel = ButtonViewModel(action: presenter.next,
                                              systemImageName: Layout.NextButton.imageName,
                                                      size: ButtonSize.secondary,
                                              padding: 8)
        return AnyView(ButtonView(viewModel: buttonViewModel))
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerFactory.make()
    }
}


// MARK: - PlayerViewOutput
extension PlayerView: PlayerViewOutput {
    func enabledPlayButton() -> AnyView {
        let buttonViewModel = ButtonViewModel(action: presenter.play,
                                              systemImageName: Layout.PlayButton.imageName,
                                              size: ButtonSize.primary,
                                              padding: 8)
        return AnyView(ButtonView(viewModel: buttonViewModel))
    }
    
    func disabledPlayButton() -> AnyView {
        let buttonViewModel = ButtonViewModel(action: presenter.pause,
                                              systemImageName: Layout.PauseButton.imageName,
                                              size: ButtonSize.primary,
                                              padding: 8)
        return AnyView(ButtonView(viewModel: buttonViewModel))
    }
    
    func enabledShuffleButton() -> AnyView {
        let buttonViewModel = ButtonViewModel(action: presenter.disableShuffle,
                                              systemImageName: Layout.EnabledShuffleButton.imageName,
                                              size: ButtonSize.tertiary,
                                              padding: 8)
        return AnyView(ButtonView(viewModel: buttonViewModel))
    }
    
    func disabledShuffleButton() -> AnyView {
        let buttonViewModel = ButtonViewModel(action: presenter.enableShuffle,
                                              systemImageName: Layout.DisabledShuffleButton.imageName,
                                              size: ButtonSize.tertiary,
                                              padding: 8)
        return AnyView(ButtonView(viewModel: buttonViewModel))
    }
    
    func enabledRepeatButton() -> AnyView {
        let buttonViewModel = ButtonViewModel(action: presenter.disableRepeat,
                                              systemImageName: Layout.EnabledRepeatButton.imageName,
                                              size: ButtonSize.tertiary,
                                              padding: 8)
        return AnyView(ButtonView(viewModel: buttonViewModel))
    }
    
    func disabledRepeatButton() -> AnyView {
        let buttonViewModel = ButtonViewModel(action: presenter.enableRepeat,
                                              systemImageName: Layout.DisabledRepeatButton.imageName,
                                              size: ButtonSize.tertiary,
                                              padding: 8)
        return AnyView(ButtonView(viewModel: buttonViewModel))
    }
}
