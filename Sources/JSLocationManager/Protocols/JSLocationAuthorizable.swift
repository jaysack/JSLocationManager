//
//  JSLocationAuthorizable.swift
//  JSLocationManager
//
//  Created by Jonathan Sack on 2/23/24.
//

import CoreLocation

public protocol JSLocationAuthorizable {
    var manager: CLLocationManager { get }
    var authorizationStatus: CLAuthorizationStatus { get }
    var isAuthorized: Bool { get }
    var isLocationEnabled: Bool { get }
    func requestAuthorization(_ authorizationLevel: CLAuthorizationStatus)
}

public extension JSLocationAuthorizable {
    // Authorization status
    var authorizationStatus: CLAuthorizationStatus { manager.authorizationStatus }
    
    // Is authorized
    var isAuthorized: Bool {
        #if os(iOS) || os(watchOS) || os(tvOS)
        return authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse
        #elseif os(macOS)
        return authorizationStatus == .authorizedAlways
        #endif
    }

    // Is location enabled
    var isLocationEnabled: Bool { CLLocationManager.locationServicesEnabled() }

    // Request authorization
    func requestAuthorization(_ authorizationLevel: CLAuthorizationStatus) {
        switch authorizationLevel {
        #if os(iOS) || os(watchOS) || os(tvOS)
        case .authorizedAlways:     manager.requestAlwaysAuthorization()
        case .authorizedWhenInUse:  manager.requestWhenInUseAuthorization()
        #elseif os(macOS)
        case .authorizedAlways:     manager.requestAlwaysAuthorization()
        #endif
        default:                    return
        }
    }
}

