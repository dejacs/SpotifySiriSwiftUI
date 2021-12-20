//
//  PlaylistShortcut.swift
//  PlayForMe
//
//  Created by Jade Silveira on 19/12/21.
//

import Foundation

struct PlaylistShortcut: ShortcutModeling {
    let type: ShortcutType = .playlist
    let title: String = "Pesquisar playlist"
    let suggestedInvocationPhrase: String = "Pesquisar"
}
