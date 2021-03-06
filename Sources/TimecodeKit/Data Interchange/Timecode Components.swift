//
//  Timecode Components.swift
//  TimecodeKit
//
//  Created by Steffan Andrews on 2020-06-15.
//  Copyright © 2020 Steffan Andrews. All rights reserved.
//

import Foundation

extension Timecode {
	
	/// Timecode components.
	/// When setting, invalid values will cause the setter to fail silently. (Validation is based on the frame rate and `upperLimit` property.)
	public var components: Components {
		get {
			return Components(d: days,
							  h: hours,
							  m: minutes,
							  s: seconds,
							  f: frames,
							  sf: subFrames)
		}
		set {
			_ = setTimecode(exactly: newValue)
		}
	}
	
	/** Set timecode from tuple values.
	Returns true/false depending on whether the string values are valid or not.
	Values which are out-of-bounds will return false. (Validation is based on the frame rate and `upperLimit` property.)
	*/
	@discardableResult
	public mutating func setTimecode(exactly values: Components) -> Bool {
		
		guard values.invalidComponents(at: frameRate,
									   limit: upperLimit,
									   subFramesDivisor: subFramesDivisor).count == 0
			else { return false }
		
		days = values.d
		hours = values.h
		minutes = values.m
		seconds = values.s
		frames = values.f
		subFrames = values.sf
		
		return true
	}
	
	/** Set timecode from tuple values.
	(Validation is based on the frame rate and `upperLimit` property.)
	*/
	public mutating func setTimecode(clamping values: Components) {
		days = values.d
		hours = values.h
		minutes = values.m
		seconds = values.s
		frames = values.f
		subFrames = values.sf
		
		clampComponents()
	}
	
	/** Set timecode from tuple values.
	Timecode will wrap if out-of-bounds. Will handle negative values and wrap accordingly. (Wrapping is based on the frame rate and `upperLimit` property.)
	*/
	public mutating func setTimecode(wrapping values: Components) {
		// guaranteed to work so we can ignore the value returned
		
		_ = setTimecode(exactly: __add(wrapping: values, to: Components(f: 0)))
	}
	
	/** Set timecode from tuple values.
	Timecode values will not be validated or rejected if they overflow.
	*/
	public mutating func setTimecode(rawValues values: Components) {
		days = values.d
		hours = values.h
		minutes = values.m
		seconds = values.s
		frames = values.f
		subFrames = values.sf
	}
	
}
