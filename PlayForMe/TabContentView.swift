//
//  TabContentView.swift
//  PlayForMe
//
//  Created by Jade Silveira on 11/12/21.
//

import SwiftUI
import IntentsUI

private enum Layout {
    enum TabHome: String {
        case title = "Home"
        case imageName = "music.note.house.fill"
    }
    enum TabPlayer: String {
        case title = "Player"
        case imageName = "play.fill"
    }
    enum TabSiri: String {
        case title = "Siri"
        case imageName = "mic.fill.badge.plus"
    }
}

struct TabContentView: View {
    var body: some View {
        TabView {
            CustomTabView(content: AnyView(ConnectView()))
                .tabItem() {
                    Text(Layout.TabHome.title.rawValue)
                    Image(systemName: Layout.TabHome.imageName.rawValue)
                }
            
            CustomTabView(content: AnyView(PlayerFactory.make()))
                .tabItem() {
                    Text(Layout.TabPlayer.title.rawValue)
                    Image(systemName: Layout.TabPlayer.imageName.rawValue)
                }
            
            CustomTabView(content: AnyView(ShortcutView()))
                .tabItem() {
                    Text(Layout.TabSiri.title.rawValue)
                    Image(systemName: Layout.TabSiri.imageName.rawValue)
                }
        }
    }
}

struct TabContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabContentView()
    }
}
