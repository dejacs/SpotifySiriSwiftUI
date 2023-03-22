//
//  ShortcutManager.swift
//  PlayForMe
//
//  Created by Jade Silveira on 12/12/21.
//

import Foundation
import Intents
import CoreSpotlight
import MobileCoreServices
import UIKit

@available(iOS 12.0, *)
final class ShortcutManager {
    static let shared = ShortcutManager()
    
    func create(shortcut: ShortcutModeling) -> NSUserActivity {
        let activity = NSUserActivity(activityType: shortcut.type.rawValue)
        activity.title = shortcut.title
        activity.suggestedInvocationPhrase = shortcut.suggestedInvocationPhrase
        activity.persistentIdentifier = NSUserActivityPersistentIdentifier(shortcut.type.rawValue)
        activity.isEligibleForPrediction = true
        
        let attributes = CSSearchableItemAttributeSet(itemContentType: kUTTypeItem as String)
        attributes.thumbnailData = UIImage(named: "img_launcher")?.jpegData(compressionQuality: 1.0)
        activity.contentAttributeSet = attributes
        
        return activity
    }
}
