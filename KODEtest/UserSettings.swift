//
//  UserSettings.swift
//  KODEtest
//
//  Created by Vicodin on 17.03.2024.
//

import Foundation

final class UserSettings {
    
    private enum SettingsKeys: String {
        case sortMarkerState
    }
    
    static var sortMarkerState: Int! {
        get {
            return UserDefaults.standard.integer(forKey: SettingsKeys.sortMarkerState.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.sortMarkerState.rawValue
            if let checkMark = newValue {
                print("Value: \(checkMark) was added to key \(key)")
                defaults.set(checkMark, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
