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
import RxSwift

/// Vector
public struct Vector {
    
    /// The x
    public var x: Double
    
    /// The y
    public var y: Double
    
    /// The z
    public var z: Double
    
    /// The timestamp
    public var timestamp: TimeInterval
}

extension Vector {
    internal init(_ data: CMAccelerometerData) {
        self.x = data.acceleration.x
        self.y = data.acceleration.y
        self.z = data.acceleration.z
        self.timestamp = data.timestamp
    }
    
    internal init(_ data: CMGyroData) {
        self.x = data.rotationRate.x
        self.y = data.rotationRate.y
        self.z = data.rotationRate.z
        self.timestamp = data.timestamp
    }
    
    internal init(_ data: CMMagnetometerData) {
        self.x = data.magneticField.x
        self.y = data.magneticField.y
        self.z = data.magneticField.z
        self.timestamp = data.timestamp
    }
    
    internal init(_ rotationRate: CMRotationRate, timestamp: TimeInterval) {
        self.x = rotationRate.x
        self.y = rotationRate.y
        self.z = rotationRate.z
        self.timestamp = timestamp
    }

    internal init(_ gravity: CMAcceleration, timestamp: TimeInterval) {
        self.x = gravity.x
        self.y = gravity.y
        self.z = gravity.z
        self.timestamp = timestamp
    }
    
    internal init(_ magneticField: CMMagneticField, timestamp: TimeInterval) {
        self.x = magneticField.x
        self.y = magneticField.y
        self.z = magneticField.z
        self.timestamp = timestamp
    }
}
