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

/// Rotation matrix.
///  Wrapper for `CMRotationMatrix`
public struct RotationMatrix {
    public let m11: Double
    public let m12: Double
    public let m13: Double
    public let m21: Double
    public let m22: Double
    public let m23: Double
    public let m31: Double
    public let m32: Double
    public let m33: Double
    
    /// Matrix representation which
    /// inner array represents a row
    public let m: [[Double]]
}

extension RotationMatrix {
    internal init(_ rotationMatrix: CMRotationMatrix) {
        self.m11 = rotationMatrix.m11
        self.m12 = rotationMatrix.m12
        self.m13 = rotationMatrix.m13
        self.m21 = rotationMatrix.m21
        self.m22 = rotationMatrix.m22
        self.m23 = rotationMatrix.m23
        self.m31 = rotationMatrix.m31
        self.m32 = rotationMatrix.m32
        self.m33 = rotationMatrix.m33
        self.m = [
            [m11, m12, m13],
            [m21, m22, m23],
            [m31, m32, m33]
        ]
    }
}
