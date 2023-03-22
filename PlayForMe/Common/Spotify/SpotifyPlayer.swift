import SpotifyiOS

protocol SpotifyPlayerProtocol: SPTAppRemotePlayerStateDelegate {
    func updateLastPlayerState(_ playerState: SPTAppRemotePlayerState?)
    func set(spotifyPlayerDelegate: SpotifyPlayerDelegate?)
}

final class SpotifyPlayer: NSObject {
    private var lastPlayerState: SPTAppRemotePlayerState?
    
    private var isPlayerPaused: Bool {
        lastPlayerState?.isPaused ?? false
    }
    
    private weak var spotifyPlayerDelegate: SpotifyPlayerDelegate?
    
    func set(spotifyPlayerDelegate: SpotifyPlayerDelegate?) {
        self.spotifyPlayerDelegate = spotifyPlayerDelegate
    }
    
    func didTapPauseOrPlay() {
        isPlayerPaused ? spotifyPlayerDelegate?.pause() : spotifyPlayerDelegate?.resume()
    }
}

extension SpotifyPlayer: SpotifyPlayerProtocol {
    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
        guard lastPlayerState?.track.uri != playerState.track.uri else { return }
        lastPlayerState = playerState
        spotifyPlayerDelegate?.playerStateDidChange(playerState: playerState)
    }
    
    func updateLastPlayerState(_ playerState: SPTAppRemotePlayerState?) {
        lastPlayerState = playerState
    }
}
