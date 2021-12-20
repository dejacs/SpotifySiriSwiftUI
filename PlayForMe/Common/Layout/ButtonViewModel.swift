//
//  ButtonViewModel.swift
//  PlayForMe
//
//  Created by Jade Silveira on 19/12/21.
//

import SwiftUI

struct ButtonViewModel {
    let action: () -> Void
    let systemImageName: String
    let size: CGSize
    let padding: CGFloat
}
