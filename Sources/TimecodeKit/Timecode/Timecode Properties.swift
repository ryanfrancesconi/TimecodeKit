//
//  Timecode Properties.swift
//  TimecodeKit • https://github.com/orchetect/TimecodeKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

import Foundation

extension Timecode {
    /// ``Timecode`` properties.
    public struct Properties: Equatable, Hashable {
        /// Frame rate.
        ///
        /// Note: Several properties are available on the frame rate that is selected, including its
        /// ``stringValue`` representation or whether the rate ``TimecodeFrameRate/isDrop``.
        ///
        /// Setting this value directly does not trigger any validation.
        public var frameRate: TimecodeFrameRate
        
        /// Subframes base (divisor).
        ///
        /// The number of subframes that make up a single frame.
        ///
        /// (ie: a divisor of 80 subframes per frame implies a visible value range of 00...79)
        ///
        /// This will vary depending on application. Most common divisors are 80 or 100.
        public var subFramesBase: SubFramesBase
        
        /// Timecode maximum upper bound.
        ///
        /// This also affects how timecode values wrap when adding or clamping.
        ///
        /// Setting this value directly does not trigger any validation.
        public var upperLimit: UpperLimit
        
        public init(
            rate: TimecodeFrameRate,
            base: SubFramesBase = .default(),
            limit: UpperLimit = ._24hours
        ) {
            frameRate = rate
            subFramesBase = base
            upperLimit = limit
        }
    }
}

extension Timecode.Properties: Codable { }
