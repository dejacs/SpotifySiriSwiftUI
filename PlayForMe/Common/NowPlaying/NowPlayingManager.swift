//
//  NowPlayingManager.swift
//  PlayForMe
//
//  Created by Jade Silveira on 14/12/21.
//

import MediaPlayer

final class NowPlayingManager {
    static let shared = NowPlayingManager()
    
    func setupNowPlaying(audioStreaming: SPTAudioStreamingController?) {
        var nowPlayingInfo = [String : Any]()
        nowPlayingInfo[MPMediaItemPropertyTitle] = audioStreaming?.metadata.currentTrack?.name
        nowPlayingInfo[MPMediaItemPropertyAlbumTitle] = audioStreaming?.metadata.currentTrack?.albumName
        nowPlayingInfo[MPMediaItemPropertyArtist] = audioStreaming?.metadata.currentTrack?.artistName
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = audioStreaming?.metadata.currentTrack?.duration
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
        MPNowPlayingInfoCenter.default().playbackState = .playing
        
        setupRemoteCommandCenter()
    }
    
    func setupRemoteCommandCenter() {
        let commandCenter = MPRemoteCommandCenter.shared();
        commandCenter.playCommand.isEnabled = true
        commandCenter.playCommand.addTarget { event in
            SpotifyConnect.shared.play()
            return .success
        }
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.pauseCommand.addTarget { event in
            SpotifyConnect.shared.pause()
            return .success
        }
        commandCenter.nextTrackCommand.isEnabled = true
        commandCenter.nextTrackCommand.addTarget { event in
            SpotifyConnect.shared.pause()
            SpotifyConnect.shared.next()
            return .success
        }
        commandCenter.previousTrackCommand.isEnabled = true
        commandCenter.previousTrackCommand.addTarget { event in
            SpotifyConnect.shared.pause()
            SpotifyConnect.shared.previous()
            return .success
        }
    }
}
