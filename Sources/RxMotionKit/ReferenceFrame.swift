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

/// Reference frame.
///  Wrapper for `CMAttitudeReferenceFrame`
public enum ReferenceFrame {
    
    /// X arbitrary, Z vertical
    case xArbitraryZVertical
    
    /// X arbitrary corrected, Z vertical
    case xArbitraryCorrectedZVertical
    
    /// X magnetic north, Z vertical
    case xMagneticNorthZVertical
    
    /// Z true north, Z vertical
    case xTrueNorthZVertical
    
    internal var coreMotionReferenceFrame: CMAttitudeReferenceFrame {
        switch self {
        case .xArbitraryZVertical:
            return .xArbitraryZVertical
        case .xArbitraryCorrectedZVertical:
            return .xArbitraryCorrectedZVertical
        case .xMagneticNorthZVertical:
            return .xMagneticNorthZVertical
        case .xTrueNorthZVertical:
            return .xTrueNorthZVertical
        }
    }
}
