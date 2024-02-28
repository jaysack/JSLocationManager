//
//  JSLocationPlacemarkable.swift
//  JSLocationManager
//
//  Created by Jonathan Sack on 2/23/24.
//

import CoreLocation

public protocol JSLocationPlacemarkable: JSLocationReceiveable {
    var geocoder: CLGeocoder { get }
    var currentPlacemark: CLPlacemark? { get }
    func getPlacemarks() async throws -> [CLPlacemark]
    func cancelGeocode()
}

public extension JSLocationPlacemarkable {
    func cancelGeocode() {
        geocoder.cancelGeocode()
    }
}
