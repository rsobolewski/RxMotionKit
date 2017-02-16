/**
 *  RxMotionKit
 *
 *  Copyright (c) 2017 Robert Sobolewski. Licensed under the MIT license, as follows:
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

import Foundation
import CoreMotion

/// Motion sources provider
/// Contains all possible sources of motion sensors
internal final class MotionSourcesProvider: MotionSourcesProviderType, CoreMotionManagerInitializable {
    internal let accelemeterSource: AnyMotionSource
    internal let gyroscopeSource: AnyMotionSource
    internal let magnetometerSource: AnyMotionSource
    internal let deviceMotionSource: AnyMotionSource
    internal var sources: Set<AnyMotionSource> {
        return Set<AnyMotionSource>([
            accelemeterSource,
            gyroscopeSource,
            magnetometerSource,
            deviceMotionSource
        ])
    }
    
    // MARK: - Initialization
    
    internal init(
        accelemeterSource: AnyMotionSource,
        gyroscopeSource: AnyMotionSource,
        magnetometerSource: AnyMotionSource,
        deviceMotionSource: AnyMotionSource) {
        self.accelemeterSource = accelemeterSource
        self.gyroscopeSource = gyroscopeSource
        self.magnetometerSource = magnetometerSource
        self.deviceMotionSource = deviceMotionSource
    }
    
    internal convenience init(_ motionManager: CMMotionManager) {
        self.init(
            accelemeterSource: AnyMotionSource(Accelerometer(motionManager)),
            gyroscopeSource: AnyMotionSource(Gyroscope(motionManager)),
            magnetometerSource: AnyMotionSource(Magnetometer(motionManager)),
            deviceMotionSource: AnyMotionSource(DeviceMotion(motionManager))
        )
    }
}
