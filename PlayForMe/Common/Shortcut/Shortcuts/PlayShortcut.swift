//
//  PlayShortcut.swift
//  PlayForMe
//
//  Created by Jade Silveira on 19/12/21.
//

import Foundation

struct PlayShortcut: ShortcutModeling {
    let type: ShortcutType = .play
    let title: String = "Tocar música"
    let suggestedInvocationPhrase: String = "Tocar"
}
