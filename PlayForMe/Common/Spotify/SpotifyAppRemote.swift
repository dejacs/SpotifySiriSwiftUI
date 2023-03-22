import SpotifyiOS.SPTAppRemote

protocol SpotifyAppRemoteProtocol: SPTAppRemoteDelegate {
    func set(spotifyAppRemoteDelegate: SpotifyAppRemoteDelegate?)
}

final class SpotifyAppRemote: NSObject {
    private weak var spotifyAppRemoteDelegate: SpotifyAppRemoteDelegate?
    
    func set(spotifyAppRemoteDelegate: SpotifyAppRemoteDelegate?) {
        self.spotifyAppRemoteDelegate = spotifyAppRemoteDelegate
    }
}

extension SpotifyAppRemote: SpotifyAppRemoteProtocol {
    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
        spotifyAppRemoteDelegate?.appRemoteDidEstablishConnection(appRemote: appRemote)
    }

    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
        spotifyAppRemoteDelegate?.didDisconnectWithError()
    }

    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
        spotifyAppRemoteDelegate?.didFailConnectionAttemptWithError()
    }
}
