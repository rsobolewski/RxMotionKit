![RxMotionKit](http://i.imgur.com/UCe4ajH.png)

[![Platform](https://img.shields.io/cocoapods/p/RxMotionKit.svg?style=flat)](http://cocoapods.org/pods/RxMotionKit)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/RxMotionKit.svg)](https://img.shields.io/cocoapods/v/RxMotionKit.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

RxMotionKit is a motion sensors managing library written in Swift.

- [Features](#features)
- [Description](#description)
- [Requirements](#requirements)
- [Installation](#installation)
	- [CocoaPods](#cocoapods)
	- [Carthage](#carthage)
- [Usage](#usage)
- [Communication](#communication)
- [Author](#author)
- [License](#license)


## Features

- [x] CoreMotion RxSwift support
- [x] Swifty interface
- [x] Pleasant data model

## Description

Library wraps CoreMotion and RxSwift frameworks and provides pleasant way to obtain data from sensors.

## Requirements

* Xcode 8.1+
* Swift 3.0+

## Installation

#### CocoaPods

RxMotionKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply specify it in your `Podfile`:

```ruby
pod 'RxMotionKit', '~> 0.7.0'
```

Then, run the following command:

```bash
$ pod install
```

#### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate RxMotionKit into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "rsobolewski/RxMotionKit" ~> 0.7.0
```

Run `carthage update` to build the frameworks and drag them into your Xcode project.

## Usage

#### Start motions source updates

To start updating data from sensors import `RxMotionKit` module and get reference to singleton instance of `MotionManager`:

```swift
import RxSwift
import RxMotionKit

unowned let motionManager = MotionManager.shared
```

subscribe an Observable:

```swift
motionManager.rx_didUpdateMotionData
	.subscribe(onNext: { (data) in
		// Handle received data
	})
```

and start updating selected sources:

```swift
motionManager.startUpdating([
    .accelerometr,
    .gyroscope,
    .magnetometr,
    .deviceMotion
    ],
    withInterval: 5.0
)
```

For convenient usage when you want to obtain few updates you can use `take` to automatically stop updates when defined limit is reached:

```swift
motionManager.rx_didUpdateMotionData
	.take(4)
	.subscribe(onNext: { (data) in
		// Handle received data
	})
```

#### Stop motions source updates

To stop updates from selected sources:

```swift
motionManager.stopUpdating([
    .accelerometr,
    .gyroscope,
    .magnetometr,
    .deviceMotion
])
```

#### Types of motion source

All motion sources that are available: 

- `accelerometr` - Accelerometer
- `gyroscope` - Gyroscope
- `magnetometr` - Magnetometr
- `deviceMotion` - DeviceMotion

Also you can conveniently specify all motion sources using `MotionSourceType.all`.

#### Types of Observables

There are several types of Observables provided by `MotionManager`:

* `rx_didUpdateMotionData` - general observable for motion data updates, that merges all events from all source updates
* `rx_didUpdateAccelerometerData` - accelerometer updates
* `rx_didUpdateGyroscopeData` - gyroscope updates
* `rx_didUpdateMagnetometerData` - magnetometer updates
* `rx_didUpdateDeviceMotionData` - device motion updates

#### Updates configuration

All sources require the update time interval, that must be provided in method which start updates:

```swift
let updateTimeInterval = 1.0 // 1 sec
startUpdating([.accelerometer], withInterval: updateTimeInterval)
```

For device motion updates you can choose a reference frame for attitude, which will be default if you not provide any.

```swift
startUpdating([.accelerometer], withInterval: updateTimeInterval, referenceFrame: .xArbitraryZVertical)
```

## Communication

If you want to contribute, please submit a pull request. For code consistency please use SwiftLint with configuration from this repository.  

## Author

Robert Sobolewski, contact me on [Twitter](https://twitter.com/robsobolewski)

## License

RxMotionKit is available under the MIT license. See the LICENSE file for more info.
