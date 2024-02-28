//
//  JSLocationReceiveable.swift
//  JSLocationManager
//
//  Created by Jonathan Sack on 2/23/24.
//

import CoreLocation

public protocol JSLocationReceiveable: JSLocationAuthorizable {
    var location: CLLocation? { get }
    func setAccuracy(_ accuracy: CLLocationAccuracy)
    func requestLocation() throws
}

public extension JSLocationReceiveable {
    // Location
    var location: CLLocation? { manager.location }

    // Set accuracy
    func setAccuracy(_ accuracy: CLLocationAccuracy) {
        manager.desiredAccuracy = accuracy
    }
}
