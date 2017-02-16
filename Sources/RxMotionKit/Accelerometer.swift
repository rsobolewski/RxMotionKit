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

/// Accelerometer
internal class Accelerometer: MotionSource, CoreMotionManagerInitializable {
    
    private unowned let motionManager: CMMotionManager
    
    // MARK: - Initialization
    
    internal required init(_ motionManager: CMMotionManager) {
        self.motionManager = motionManager
    }
    
    // MARK: - Motion source
    
    internal let _rx_didUpdateData = PublishSubject<MotionData>()
    
    internal var type: MotionSourceType {
        return .accelerometr
    }
    
    internal var isActive: Bool {
        return motionManager.isAccelerometerActive
    }
    
    internal var isAvailable: Bool {
        return motionManager.isAccelerometerAvailable
    }
    
    internal func startUpdates(with updateInterval: TimeInterval, referenceFrame: ReferenceFrame?) {
        guard startCondition else { return }
        motionManager.accelerometerUpdateInterval = updateInterval
        motionManager.startAccelerometerUpdates(to: OperationQueue()) { [weak self] (data, error) in
            guard let `self` = self else { return }
            switch MotionResultConverter.result(data, error) {
            case .failure(let error):
                self._rx_didUpdateData.onError(error)
            case .success(let data):
                self._rx_didUpdateData.onNext(
                    .accelerometr(
                        acceleration: Vector(data)
                    )
                )
            }
        }
    }
    
    internal func stopUpdates() {
        guard stopCondition else { return }
        motionManager.stopAccelerometerUpdates()
        _rx_didUpdateData.onCompleted()
    }
}
