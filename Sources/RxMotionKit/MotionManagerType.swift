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
import RxSwift

/// Motion manager type protocol
public protocol MotionManagerType: class {
    
    /// General observable for motion data updates
    /// Merges all events from all source updates
    var rx_didUpdateMotionData: Observable<MotionData> { get }
    
    /// Accelerometer updates observable
    var rx_didUpdateAccelerometerData: Observable<MotionData> { get }
    
    /// Gyroscope updates observable
    var rx_didUpdateGyroscopeData: Observable<MotionData> { get }
    
    /// Magnetometer updates observable
    var rx_didUpdateMagnetometerData: Observable<MotionData> { get }
    
    /// Device motion updates observable
    var rx_didUpdateDeviceMotionData: Observable<MotionData> { get }
    
    /// Start updating motion sources with time interval and reference frame.
    /// You can specify multiple sources at once.
    ///
    /// - Parameters:
    ///   - sources: The source types to start updating
    ///   - interval: The time interval for updates
    ///   - referenceFrame: The reference frame used for ony device motion updates.
    ///                     If none is provided, the default will be applied
    func startUpdating(
        _ sources: [MotionSourceType], withInterval interval: TimeInterval, referenceFrame: ReferenceFrame?
    )
    
    /// Stops updating motion sources.
    /// You can specify multiple sources at once.
    ///
    /// - Parameter sources: The source types to be stop updating
    func stopUpdating(
        _ sources: [MotionSourceType]
    )
}
