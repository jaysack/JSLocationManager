//
//  JSLocationManagerNotificationCenter.swift
//  JSLocationManager
//
//  Created by Jonathan Sack on 2/23/24.
//

import Foundation

public final class JSLocationManagerNotificationCenter: NotificationCenter {
    fileprivate override init() {
        super.init()
    }
}

extension NotificationCenter {
    public static let locationUpdates = JSLocationManagerNotificationCenter()
}
