//
//  PreviousShortcut.swift
//  PlayForMe
//
//  Created by Jade Silveira on 19/12/21.
//

import Foundation

struct PreviousShortcut: ShortcutModeling {
    let type: ShortcutType = .previous
    let title: String = "Voltar música"
    let suggestedInvocationPhrase: String = "Voltar"
}
