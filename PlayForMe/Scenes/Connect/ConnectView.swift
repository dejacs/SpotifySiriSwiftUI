//
//  ConnectView.swift
//  PlayForMe
//
//  Created by Jade Silveira on 18/12/21.
//

import SwiftUI

struct ConnectView: View {
    private let spotifyManager: SpotifyManagerProtocol = SpotifyManager.shared
    
    var body: some View {
        VStack {
            Button(action: connect) {
                Image(systemName: "waveform.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24.0, height: 24.0)
                    .foregroundColor(.accentColor)
                Text("Connect")
                    .fontWeight(.medium)
                    .font(.title2)
                    .foregroundColor(.accentColor)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.accentColor, lineWidth: 2)
            )
            Button(action: searchPlaylist) {
                Image(systemName: "mic.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24.0, height: 24.0)
                    .foregroundColor(.accentColor)
                Text("Search")
                    .fontWeight(.medium)
                    .font(.title2)
                    .foregroundColor(.accentColor)
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.accentColor, lineWidth: 2)
            )
        }
    }
}

private extension ConnectView {
    func connect() {
        spotifyManager.connect()
    }
    
    func searchPlaylist() {
        SpeechRecognitionManager.shared.start()
    }
}

struct ConnectView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectView()
    }
}
