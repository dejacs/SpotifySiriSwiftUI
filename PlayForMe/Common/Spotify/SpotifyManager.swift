import SpotifyiOS

protocol SpotifyAppRemoteDelegate: AnyObject {
    func appRemoteDidEstablishConnection(appRemote: SPTAppRemote)
    func didDisconnectWithError()
    func didFailConnectionAttemptWithError()
}

protocol SpotifySessionDelegate: AnyObject {
    func didInitiate(accessToken: String)
}

protocol SpotifyPlayerDelegate: AnyObject {
    func playerStateDidChange(playerState: SPTAppRemotePlayerState)
    
    func play(uri: String)
    func pause()
    func resume()
}

protocol SpotifyManagerProtocol {
    func connect()
    func disconnect()
    func openedUrl(application: UIApplication, url: URL)
    
    func play(uri: String)
    func pause()
    func resume()
}

final class SpotifyManager {
    static let shared: SpotifyManagerProtocol = SpotifyManager()
    
    private let SpotifyClientID = "2263931645e348ab96e4555e93c6c12c"
    private let SpotifyRedirectURI = URL(string: "playForMe://loginCallback")!
    
    private var appRemoteDelegate: SpotifyAppRemoteProtocol?
    private var sessionDelegate: SpotifySessionProtocol?
    private var playerDelegate: SpotifyPlayerProtocol?
    private var presenterDelegate: PlayerPresenterDelegate?
    
    private lazy var configuration: SPTConfiguration = {
        let configuration = SPTConfiguration(clientID: SpotifyClientID, redirectURL: SpotifyRedirectURI)
        // Set the playURI to a non-nil value so that Spotify plays music after authenticating and App Remote can connect
        // otherwise another app switch will be required
        configuration.playURI = "6PbRfvvnsJr6fIi3iunNyn?si=fe76b4863285421d"

        // Set these url's to your backend which contains the secret to exchange for an access token
        // You can use the provided ruby script spotify_token_swap.rb for testing purposes
//        configuration.tokenSwapURL = URL(string: "http://localhost:1234/swap")
//        configuration.tokenRefreshURL = URL(string: "http://localhost:1234/refresh")
        return configuration
    }()
    
    private lazy var appRemote: SPTAppRemote = {
        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
        appRemote.delegate = appRemoteDelegate
        return appRemote
    }()
    
    private lazy var sessionManager: SPTSessionManager = {
        let manager = SPTSessionManager(configuration: configuration, delegate: sessionDelegate)
        return manager
    }()
    
    init(appRemoteDelegate: SpotifyAppRemoteProtocol? = SpotifyAppRemote(),
         sessionDelegate: SpotifySessionProtocol? = SpotifySession(),
         playerDelegate: SpotifyPlayerProtocol? = SpotifyPlayer()) {
//         configuration: SPTConfiguration,
//         appRemote: SPTAppRemote,
//         sessionManager: SPTSessionManager) {
        appRemoteDelegate?.set(spotifyAppRemoteDelegate: self)
        sessionDelegate?.set(spotifySessionDelegate: self)
        playerDelegate?.set(spotifyPlayerDelegate: self)
        
        self.appRemoteDelegate = appRemoteDelegate
        self.sessionDelegate = sessionDelegate
        self.playerDelegate = playerDelegate
//        self.configuration = configuration
//        self.appRemote = appRemote
//        self.sessionManager = sessionManager
    }
}

private extension SpotifyManager {
    func fetchArtwork(for track: SPTAppRemoteTrack, completion: @escaping (Result<UIImage, Error>) -> Void) {
        appRemote.imageAPI?.fetchImage(forItem: track, with: CGSize.zero) { (image, error) in
            if let error = error {
                completion(.failure(error))
            } else if let image = image as? UIImage {
                completion(.success(image))
            }
        }
    }
    
    func fetchPlayerState() {
        appRemote.playerAPI?.getPlayerState{ [playerDelegate] (playerState, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let playerState = playerState as? SPTAppRemotePlayerState {
                playerDelegate?.updateLastPlayerState(playerState)
            }
        }
    }
}

extension SpotifyManager: SpotifyManagerProtocol {
    func connect() {
        /*
         Scopes let you specify exactly what types of data your application wants to
         access, and the set of scopes you pass in your call determines what access
         permissions the user is asked to grant.
         For more information, see https://developer.spotify.com/web-api/using-scopes/.
         */
        let scope: SPTScope = [.appRemoteControl, .playlistReadPrivate]

        if #available(iOS 11, *) {
            // Use this on iOS 11 and above to take advantage of SFAuthenticationSession
            sessionManager.initiateSession(with: scope, options: .clientOnly)
        } else {
            // Use this on iOS versions < 11 to use SFSafariViewController
//            sessionManager.initiateSession(with: scope, options: .clientOnly, presenting: self)
        }
    }
    
    func disconnect() {
        guard appRemote.isConnected else { return }
        appRemote.disconnect()
    }
    
    func openedUrl(application: UIApplication, url: URL) {
        sessionManager.application(application, open: url)
    }
}

extension SpotifyManager: SpotifyAppRemoteDelegate {
    func appRemoteDidEstablishConnection(appRemote: SPTAppRemote) {
        presenterDelegate?.updateViewConnectedState()
        
        appRemote.playerAPI?.delegate = playerDelegate
        appRemote.playerAPI?.subscribe(toPlayerState: { (success, error) in
            if let error = error {
                print("Error subscribing to player state: " + error.localizedDescription)
            }
        })
        fetchPlayerState()
    }
    
    func didDisconnectWithError() {
        presenterDelegate?.updateViewDisconnectedState()
        playerDelegate?.updateLastPlayerState(nil)
    }
    
    func didFailConnectionAttemptWithError() {
        presenterDelegate?.updateViewDisconnectedState()
        playerDelegate?.updateLastPlayerState(nil)
    }
}

extension SpotifyManager: SpotifySessionDelegate {
    func didInitiate(accessToken: String) {
        appRemote.connectionParameters.accessToken = accessToken
        appRemote.connect()
    }
}

extension SpotifyManager: SpotifyPlayerDelegate {
    func playerStateDidChange(playerState: SPTAppRemotePlayerState) {
        fetchArtwork(for: playerState.track) { [presenterDelegate] result in
            switch result {
            case .success(let image):
                presenterDelegate?.updateImage(image)
                
            case .failure:
                presenterDelegate?.updateImage(nil)
            }
        }
    }
    
    func play(uri: String) {
        appRemote.contentAPI?.fetchContentItem(forURI: uri) { result, error in
            print(result)
        }
//        appRemote.playerAPI?.play(uri, asRadio: false, callback: { result, error in
//            print(result)
//        })
    }
    
    func pause() {
        appRemote.playerAPI?.pause(nil)
    }
    
    func resume() {
        appRemote.playerAPI?.resume(nil)
    }
}
