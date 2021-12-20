//
//  CustomTabView.swift
//  PlayForMe
//
//  Created by Jade Silveira on 18/12/21.
//

import SwiftUI

struct CustomTabView: View {
    let content: AnyView
    
    var body: some View {
        ZStack {
            Color("color_launcher_background").ignoresSafeArea(.all, edges: .top)
            VStack {
                Text("Play for me")
                    .fontWeight(.medium)
                    .font(.title2)
                    .foregroundColor(.accentColor)
                Divider()
                Spacer()
                content
                Spacer()
                Divider()
            }
        }
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabView(content: AnyView(ConnectView()))
    }
}
