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

/// Motion source protocol
internal protocol MotionSource: class {
    
    /// The type of motion source
    var type: MotionSourceType { get }
    
    /// The information about the source activity
    var isActive: Bool { get }
    
    /// The information about the source availabity
    var isAvailable: Bool { get }
    
    /// The publish subject of the source updates
    var _rx_didUpdateData: PublishSubject<MotionData> { get }
    
    /// The observable of the source updates
    var rx_didUpdateData: Observable<MotionData> { get }
    
    /// Determines whether source can start updates
    var startCondition: Bool { get }
    
    /// Determines whether source can stop updates
    var stopCondition: Bool { get }
    
    /// Starts source updates
    ///
    /// - Parameters:
    ///   - updateInterval: The source update interval
    ///   - referenceFrame: The reference frame of updates
    func startUpdates(
        with updateInterval: TimeInterval,
        referenceFrame: ReferenceFrame?
    )
    
    /// Stops source updates
    func stopUpdates()
}

extension MotionSource {
    var startCondition: Bool {
        guard !isActive else { return false }
        guard isAvailable else {
            _rx_didUpdateData.onError(MotionSourceError.notAvailable(type))
            return false
        }
        return true
    }
    var stopCondition: Bool {
        guard isActive else { return false }
        return true
    }
    var rx_didUpdateData: Observable<MotionData> {
        return _rx_didUpdateData.do(onDispose: {
            guard !self._rx_didUpdateData.hasObservers else { return }
            self.stopUpdates()
        })
    }
}
