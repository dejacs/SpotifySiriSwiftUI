//
//  ButtonView.swift
//  PlayForMe
//
//  Created by Jade Silveira on 19/12/21.
//

import SwiftUI

struct ButtonView: View {
    let viewModel: ButtonViewModel
    
    var body: some View {
        Button(action: viewModel.action) {
            Image(systemName: viewModel.systemImageName)
                .resizable()
                .scaledToFit()
                .frame(width: viewModel.size.width, height: viewModel.size.height)
                .padding(viewModel.padding)
                .foregroundColor(.accentColor)
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ButtonViewModel(action: {},
                                        systemImageName: "play.circle.fill",
                                        size: CGSize(width: 48, height: 48),
                                        padding: 8)
        ButtonView(viewModel: viewModel)
    }
}
