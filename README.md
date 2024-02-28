<img src="./Resources/Images/jslocationmanager-image.png">

# 🔗 JSConstraints

> 💡 A tiny Swift library for everything location.

- - - -
<br>

## Table Of Content
- [📥. Installation](#-installation)
- [📓. How It Works](#-how-it-works)
- [✉️. Author](#%EF%B8%8F-author)

- - - -
<br>

## 📥 Installation
Use SPM to install the library SPM by selecting **File** > **Swift Package** > **Add Package Dependecy** and pasting the URL below.
```
https://github.com/jaysack/JSLocationManager
```
- - - -
<br>

## 📓 How It Works?
JSLocationManager is a suite of protocols built on top of each other, and a default `JSLocationManager` object provided for quick integration.\ 
Feel free to create your custom components as needed.

### Protocols
#### JSLocationAuthorizable
The `JSLocationAuthorizable` protocol revolves around location authorization and authorization status.\
It allows you to request the device's location authorization and check the current authorization status.

#### JSLocationReceiveable
The `JSLocationReceiveable` protocol allows you to receive location on-demand (once you have receive location authorization). This protocol is used mostly to receive a specific location without further updates.

#### JSLocationMonitorable
The `JSLocationMonitorable` protocol allows you to receive a stream of locations. This protocol is mainly used when you need to continuously receive location updates like in an navigation application. **It's usually not recommended to use its methods if you're just trying to get a single location.**

#### JSLocationPlacemarkable
The `JSLocationPlacemarkable` protocol allows you to get more information about the location retrieve. It leverages Apple's' `CLGeocoder` API behind the scene to provide you with accurate location info.

#### JSLocationMonitorable
The `JSLocationMonitorable` protocol allows you to monitor a specific region on a map, like entering and leaving a specific region.

### JSLocationManager
The `JSLocationManager` object is provided to you so you don't have to manually conform to the protocol above. In most case, you should be fine with just using it instead of creating your custom objects.
```swift
import JSLocationManager

let locationManager: JSLocationManager = .shared
do {
    try locationManager.requestLocation()
    
    // Do some work here

} catch {
    print(error.localizedDescription)
}
```

### Notifications
`JSLocationManager` allows you to use the NotificationCenter of your choice to receive notifications above different location events.\
**We recommend using the provided custom `.locationUpdates` notification center for notifcation-heavy applications** as this will reduce the workload in your `NotificationCenter.default` shared object.
```swift
locationManager.notificationCenter = .locationUpdates
```
 
### Bundle Identifier
Although not required, it is recommended to set up the bundle identifier. Behind the scene it uses your app main bundle ID and can be omitted if you do not have a custom set up.\
This bundle identifier is used in notification names when posting notification using the NofiticationCenter.
- - - -
<br>

## ✉️ Author
Jonathan Sack\
dev@jonathansack.io
- - - -
<br>
