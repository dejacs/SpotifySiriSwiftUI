import SpotifyiOS

protocol SpotifySessionProtocol: SPTSessionManagerDelegate {
    func set(spotifySessionDelegate: SpotifySessionDelegate?)
}

final class SpotifySession: NSObject {
    private weak var spotifySessionDelegate: SpotifySessionDelegate?
    
    func set(spotifySessionDelegate: SpotifySessionDelegate?) {
        self.spotifySessionDelegate = spotifySessionDelegate
    }
}

extension SpotifySession: SpotifySessionProtocol {
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("Authorization Success: \(session.accessToken)")
        spotifySessionDelegate?.didInitiate(accessToken: session.accessToken)
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("Authorization Failed: \(error.localizedDescription)")
    }

    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("Session Renewed: \(session.description)")
    }
    
    func sessionManager(manager: SPTSessionManager, shouldRequestAccessTokenWith code: String) -> Bool {
        print("Authorization on hold: \(code)")
        return true
    }
}
