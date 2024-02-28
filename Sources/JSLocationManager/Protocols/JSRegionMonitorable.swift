//
//  JSRegionMonitorable.swift
//  JSLocationManager
//
//  Created by Jonathan Sack on 2/23/24.
//

import CoreLocation

public protocol JSRegionMonitorable: JSLocationMonitorable {
    var currentRegion: CLRegion? { get }
    func startMonitoringRegion(_ region: CLRegion)
    func stopMonitoringRegion(_ region: CLRegion)
}

public extension JSRegionMonitorable {
    // Start monitoring region
    func startMonitoringRegion(_ region: CLRegion) {
        manager.startMonitoring(for: region)
    }
    
    // Stop monitoring region
    func stopMonitoringRegion(_ region: CLRegion) {
        manager.stopMonitoring(for: region)
    }
}
