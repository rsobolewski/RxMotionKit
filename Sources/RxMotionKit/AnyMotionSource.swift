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

/// Any motion source
/// Used for type-erase `MotionSource` protocol
internal class AnyMotionSource: MotionSource {
    
    // MARK: - Source
    
    private let motionSource: MotionSource
    
    // MARK: - Initialization
    
    internal init<Source: MotionSource>(_ source: Source) {
        self.motionSource = source
    }
    
    // MARK: - Motion source protocol
    
    internal var _rx_didUpdateData: PublishSubject<MotionData> {
        return motionSource._rx_didUpdateData
    }
    
    internal var type: MotionSourceType {
        return motionSource.type
    }
    
    internal var isActive: Bool {
        return motionSource.isActive
    }
    
    internal var isAvailable: Bool {
        return motionSource.isAvailable
    }
    
    internal func startUpdates(with updateInterval: TimeInterval, referenceFrame: ReferenceFrame?) {
        motionSource.startUpdates(with: updateInterval, referenceFrame: referenceFrame)
    }
    
    internal func stopUpdates() {
        motionSource.stopUpdates()
    }
}

func == (lhs: AnyMotionSource, rhs: AnyMotionSource) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
extension AnyMotionSource: Equatable {}

extension AnyMotionSource: Hashable {
    var hashValue: Int { return type.hashValue }
}
