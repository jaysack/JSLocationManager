//
//  JSLocationManager.swift
//  JSLocationManager
//
//  Created by Jonathan Sack on 2/23/24.
//

import Foundation
import CoreLocation

public final class JSLocationManager: NSObject, JSLocationAuthorizable, JSLocationMonitorable, JSRegionMonitorable {

    // MARK: - Dependencies
    public var notificationCenter: NotificationCenter?

    // MARK: - Properties
    public static let shared = JSLocationManager()
    public static var bundleIdentifier: String = Bundle.main.bundleIdentifier ?? ""
    public lazy var geocoder = CLGeocoder()
    public lazy var manager = CLLocationManager()
    public private(set) var currentRegion: CLRegion?
    public private(set) var currentPlacemark: CLPlacemark?
    
    // MARK: - Init
    private override init() {
        super.init()
        manager.delegate = self
    }
}

// MARK: - EXT. KSLocation Receivable
extension JSLocationManager: JSLocationReceiveable {
    // Request location
    public func requestLocation() throws {
        // Check authorization status
        try checkLocationAuthorizationStatus()
        // Post location request notification
        notificationCenter?.post(name: JSLocationManager.didRequestLocations, object: nil)
        // Request location
        manager.requestLocation()
    }
}

// MARK: - EXT. KSLocation Placemarkable
extension JSLocationManager: JSLocationPlacemarkable {
    // Get placemarks
    public func getPlacemarks() async throws -> [CLPlacemark] {
        // Check authorization status
        try checkLocationAuthorizationStatus()
        // Post geocoder request notification
        notificationCenter?.post(name: JSLocationManager.didRequestPlacemarks, object: nil)
        // Reverse geocode location
        guard let location else { throw LocationError.locationNotAvailable }
        let placemarks = try await geocoder.reverseGeocodeLocation(location)
        currentPlacemark = placemarks.last
        // Post placemarks received
        notificationCenter?.post(name: JSLocationManager.didUpdatePlacemarks, object: nil, userInfo: ["placemarks": placemarks])
        // Return placemarks
        return placemarks
    }
}

// MARK: - ENUM. Location Manager Error
public extension JSLocationManager {
    enum LocationError: Error {
        case locationNotAvailable
        case locationNotDetermined
        case locationServicesRestricted
        case locationServicesNotEnabled
        case locationDenied
        case unknown
    }
}

// MARK: - EXT. NSNotification Name
public extension JSLocationManager {
    static let didRequestLocations: NSNotification.Name = .init("\(JSLocationManager.bundleIdentifier).didRequestLocation")
    static let didRequestPlacemarks: NSNotification.Name = .init("\(JSLocationManager.bundleIdentifier).didRequestPlacemarks")
    static let didFailLocationsUpdate: NSNotification.Name = .init("\(JSLocationManager.bundleIdentifier).didFailLocationUpdate")
    static let didUpdateLocations: NSNotification.Name = .init("\(JSLocationManager.bundleIdentifier).didUpdateLocations")
    static let didUpdatePlacemarks: NSNotification.Name = .init("\(JSLocationManager.bundleIdentifier).didUpdatePlacemarks")
    static let didChangeAuthorization: NSNotification.Name = .init("\(JSLocationManager.bundleIdentifier).didChangeAuthorization")
    static let didEnterRegion: NSNotification.Name = .init("\(JSLocationManager.bundleIdentifier).didEnterRegion")
}

// MARK: - EXT. CLLocationManager Delegate
extension JSLocationManager: CLLocationManagerDelegate {
    // Did fail with error
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        notificationCenter?.post(name: JSLocationManager.didFailLocationsUpdate, object: nil, userInfo: ["error": error])
    }
    
    // Did update location
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        notificationCenter?.post(name: JSLocationManager.didUpdateLocations, object: nil, userInfo: ["locations": locations])
    }
    
    // Did change authrorization
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        notificationCenter?.post(name: JSLocationManager.didChangeAuthorization, object: nil, userInfo: ["authorizationStatus": authorizationStatus])
    }

    // Did enter region
    public func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        guard currentRegion != region else { return }
        notificationCenter?.post(name: JSLocationManager.didEnterRegion, object: nil, userInfo: ["region": region])
    }
}

// MARK: - Private Helper
private extension JSLocationManager {
    // Handle location authorization status
    func checkLocationAuthorizationStatus() throws {
        // Handle authorization
        switch authorizationStatus {
        case .notDetermined:                            throw LocationError.locationNotDetermined
        case .restricted:                               throw LocationError.locationServicesRestricted
        case .denied:                                   throw LocationError.locationDenied
        case .authorizedAlways, .authorizedWhenInUse:   return
        default:                                        throw LocationError.unknown
        }
    }
}
