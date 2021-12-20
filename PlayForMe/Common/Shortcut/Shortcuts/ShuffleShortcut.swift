//
//  ShuffleShortcut.swift
//  PlayForMe
//
//  Created by Jade Silveira on 19/12/21.
//

import Foundation

struct ShuffleShortcut: ShortcutModeling {
    let type: ShortcutType = .shuffle
    let title: String = "Shuffle playlist"
    let suggestedInvocationPhrase: String = "Shuffle"
}
