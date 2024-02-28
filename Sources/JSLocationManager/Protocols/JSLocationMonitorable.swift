//
//  JSLocationMonitorable.swift
//  JSLocationManager
//
//  Created by Jonathan Sack on 2/23/24.
//

import CoreLocation

public protocol JSLocationMonitorable: JSLocationReceiveable {
    func startMonitoringLocation()
    func stopMonitoringLocation()
}

public extension JSLocationMonitorable {
    // Start monitoring location
    func startMonitoringLocation() {
        manager.startUpdatingLocation()
    }
    
    // Stop monitoring location
    func stopMonitoringLocation() {
        manager.stopUpdatingLocation()
    }
}
