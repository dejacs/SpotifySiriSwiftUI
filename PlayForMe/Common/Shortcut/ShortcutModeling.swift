//
//  ShortcutModeling.swift
//  PlayForMe
//
//  Created by Jade Silveira on 19/12/21.
//

import Foundation

protocol ShortcutModeling {
    var type: ShortcutType { get }
    var title: String { get }
    var suggestedInvocationPhrase: String { get }
}
