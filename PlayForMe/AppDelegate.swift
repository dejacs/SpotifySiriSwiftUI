//
//  AppDelegate.swift
//  PlayForMe
//
//  Created by Jade Silveira on 16/12/21.
//

import UIKit

final class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        return true
    }
}
