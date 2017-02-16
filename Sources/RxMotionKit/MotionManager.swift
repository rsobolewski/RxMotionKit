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

/// Motion manager
public class MotionManager: MotionManagerType {
    
    // MARK: - Singleton
    
    /// Shared instance of `MotionManager`
    public static let shared = MotionManager()
    
    // MARK: - Dependencies
    
    private lazy var motionManager: CMMotionManager = {
        return CMMotionManager()
    }()
 
    internal lazy var motionSourcesProvider: MotionSourcesProviderType = {
        return MotionSourcesProvider(self.motionManager)
    }()
    
    // MARK: - Initialization

    internal init() { }
    
    // MARK: - Observables
    
    /// General observable for motion data updates
    /// Merges all events from all source updates
    public var rx_didUpdateMotionData: Observable<MotionData> {
        return Observable.from(sourcesObservables).merge()
    }
    
    /// Accelerometer updates observable
    public var rx_didUpdateAccelerometerData: Observable<MotionData> {
        return motionSourcesProvider.accelemeterSource.rx_didUpdateData
    }
    
    /// Gyroscope updates observable
    public var rx_didUpdateGyroscopeData: Observable<MotionData> {
        return motionSourcesProvider.gyroscopeSource.rx_didUpdateData
    }
    
    /// Magnetometer updates observable
    public var rx_didUpdateMagnetometerData: Observable<MotionData> {
        return motionSourcesProvider.magnetometerSource.rx_didUpdateData
    }
    
    /// Device motion updates observable
    public var rx_didUpdateDeviceMotionData: Observable<MotionData> {
        return motionSourcesProvider.deviceMotionSource.rx_didUpdateData
    }
    
    // MARK: - Motion sources
    
    internal var sources: Set<AnyMotionSource> {
        return motionSourcesProvider.sources
    }
    
    internal var sourcesObservables: [Observable<MotionData>] {
        return sources.map { $0.rx_didUpdateData }
    }
    
    // MARK: - Motion managing

    /// Start updating motion sources with time interval and reference frame.
    /// You can specify multiple sources at once.
    ///
    /// - Parameters:
    ///   - sources: The source types to start updating
    ///   - interval: The time interval for updates
    ///   - referenceFrame: The reference frame used for ony device motion updates.
    ///                     If none is provided, the default will be applied
    public func startUpdating(
        _ sources: [MotionSourceType], withInterval interval: TimeInterval, referenceFrame: ReferenceFrame? = nil) {
        let sourceTypes = Set<MotionSourceType>(sources)
        self.sources
            .filter { sourceTypes.contains($0.type) }
            .forEach { $0.startUpdates(with: interval, referenceFrame: referenceFrame) }
    }
    
    /// Stops updating motion sources.
    /// You can specify multiple sources at once.
    ///
    /// - Parameter sources: The source types to be stop updating
    public func stopUpdating(_ sources: [MotionSourceType] = MotionSourceType.all) {
        let sourceTypes = Set<MotionSourceType>(sources)
        self.sources
            .filter { sourceTypes.contains($0.type) }
            .forEach { $0.stopUpdates() }
    }
}
