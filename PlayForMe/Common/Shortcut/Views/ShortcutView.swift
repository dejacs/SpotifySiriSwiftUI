//
//  ShortcutView.swift
//  PlayForMe
//
//  Created by Jade Silveira on 11/12/21.
//

import SwiftUI

struct ShortcutView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ShortcutViewController {
        ShortcutViewController()
    }
    
    func updateUIViewController(_ uiViewController: ShortcutViewController, context: Context) { }
}
