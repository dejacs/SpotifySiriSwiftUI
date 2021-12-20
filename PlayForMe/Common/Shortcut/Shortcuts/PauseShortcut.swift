//
//  PauseShortcut.swift
//  PlayForMe
//
//  Created by Jade Silveira on 19/12/21.
//

import Foundation

struct PauseShortcut: ShortcutModeling {
    let type: ShortcutType = .pause
    let title: String = "Pausar música"
    let suggestedInvocationPhrase: String = "Pausar"
}
