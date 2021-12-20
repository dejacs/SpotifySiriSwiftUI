//
//  ShortcutViewController.swift
//  PlayForMe
//
//  Created by Jade Silveira on 11/12/21.
//

import UIKit
import Intents
import IntentsUI

final class ShortcutViewController: UIViewController {
    private lazy var playShortcutButton: INUIAddVoiceShortcutButton = {
        let button = INUIAddVoiceShortcutButton(style: .automaticOutline)
        button.shortcut = INShortcut(userActivity: ShortcutManager.shared.create(shortcut: PlayShortcut()))
        button.delegate = self
//        button.setTitle("Adicionar 'Tocar música' à Siri", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var pauseShortcutButton: INUIAddVoiceShortcutButton = {
        let button = INUIAddVoiceShortcutButton(style: .automaticOutline)
        button.shortcut = INShortcut(userActivity: ShortcutManager.shared.create(shortcut: PauseShortcut()))
        button.delegate = self
//        button.setTitle("Adicionar 'Pausar música' à Siri", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nextShortcutButton: INUIAddVoiceShortcutButton = {
        let button = INUIAddVoiceShortcutButton(style: .automaticOutline)
        button.shortcut = INShortcut(userActivity: ShortcutManager.shared.create(shortcut: NextShortcut()))
        button.delegate = self
//        button.setTitle("Adicionar 'Próxima música' à Siri", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var previousShortcutButton: INUIAddVoiceShortcutButton = {
        let button = INUIAddVoiceShortcutButton(style: .automaticOutline)
        button.shortcut = INShortcut(userActivity: ShortcutManager.shared.create(shortcut: PreviousShortcut()))
        button.delegate = self
//        button.setTitle("Adicionar 'Voltar música' à Siri", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var playlistShortcutButton: INUIAddVoiceShortcutButton = {
        let button = INUIAddVoiceShortcutButton(style: .automaticOutline)
        button.shortcut = INShortcut(userActivity: ShortcutManager.shared.create(shortcut: PlaylistShortcut()))
        button.delegate = self
//        button.setTitle("Adicionar 'Voltar música' à Siri", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var shuffleShortcutButton: INUIAddVoiceShortcutButton = {
        let button = INUIAddVoiceShortcutButton(style: .automaticOutline)
        button.shortcut = INShortcut(userActivity: ShortcutManager.shared.create(shortcut: ShuffleShortcut()))
        button.delegate = self
//        button.setTitle("Adicionar 'Voltar música' à Siri", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        
        containerView.addArrangedSubview(playShortcutButton)
        containerView.addArrangedSubview(pauseShortcutButton)
        containerView.addArrangedSubview(nextShortcutButton)
        containerView.addArrangedSubview(previousShortcutButton)
        containerView.addArrangedSubview(playlistShortcutButton)
        containerView.addArrangedSubview(shuffleShortcutButton)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ShortcutViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

extension ShortcutViewController: INUIAddVoiceShortcutButtonDelegate {
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        addVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        editVoiceShortcutViewController.modalPresentationStyle = .formSheet
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
}

extension ShortcutViewController: INUIEditVoiceShortcutViewControllerDelegate {
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didUpdate voiceShortcut: INVoiceShortcut?, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController, didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
