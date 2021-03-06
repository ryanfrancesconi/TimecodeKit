//
//  Timecode init Tests.swift
//  TimecodeKitTests
//
//  Created by Steffan Andrews on 2020-06-16.
//  Copyright © 2020 Steffan Andrews. All rights reserved.
//

import XCTest
@testable import TimecodeKit

class Timecode_UT_init_Tests: XCTestCase {
	
	override func setUp() { }
	override func tearDown() { }
	
	
	func testTimecode_init_Defaults() {
		// essential inits
		
		// defaults
		
		var tc = Timecode(at: ._24)
		XCTAssertEqual(tc.frameRate, ._24)
		XCTAssertEqual(tc.upperLimit, ._24hours)
		XCTAssertEqual(tc.totalElapsedFrames, 0)
		XCTAssertEqual(tc.components, TCC(d: 0, h: 0, m: 0, s: 0, f: 0))
		XCTAssertEqual(tc.stringValue, "00:00:00:00")
		
		// expected intitalizers
		
		tc = Timecode(at: ._24)
		tc = Timecode(at: ._24, limit: ._24hours)
		
	}
	
	// ____ basic inits, using (exactly: ) ____
	
	func testTimecode_init_String() {
		
		Timecode.FrameRate.allCases.forEach {
			let tc = Timecode("00:00:00:00", at: $0, limit: ._24hours)
			
			XCTAssertEqual(tc?.days		, 0		, "for \($0)")
			XCTAssertEqual(tc?.hours	, 0		, "for \($0)")
			XCTAssertEqual(tc?.minutes	, 0		, "for \($0)")
			XCTAssertEqual(tc?.seconds	, 0		, "for \($0)")
			XCTAssertEqual(tc?.frames	, 0		, "for \($0)")
			XCTAssertEqual(tc?.subFrames, 0		, "for \($0)")
		}
		
		Timecode.FrameRate.allCases.forEach {
			let tc = Timecode("01:02:03:04", at: $0, limit: ._24hours)
			
			XCTAssertEqual(tc?.days		, 0		, "for \($0)")
			XCTAssertEqual(tc?.hours	, 1		, "for \($0)")
			XCTAssertEqual(tc?.minutes	, 2		, "for \($0)")
			XCTAssertEqual(tc?.seconds	, 3		, "for \($0)")
			XCTAssertEqual(tc?.frames	, 4		, "for \($0)")
			XCTAssertEqual(tc?.subFrames, 0		, "for \($0)")
		}
		
	}
	
	func testTimecode_init_Components() {
		
		Timecode.FrameRate.allCases.forEach {
			let tc = Timecode(TCC(d: 0, h: 0, m: 0, s: 0, f: 0),
									 at: $0,
									 limit: ._24hours)
			
			XCTAssertEqual(tc?.days		, 0		, "for \($0)")
			XCTAssertEqual(tc?.hours	, 0		, "for \($0)")
			XCTAssertEqual(tc?.minutes	, 0		, "for \($0)")
			XCTAssertEqual(tc?.seconds	, 0		, "for \($0)")
			XCTAssertEqual(tc?.frames	, 0		, "for \($0)")
			XCTAssertEqual(tc?.subFrames, 0		, "for \($0)")
		}
		
		Timecode.FrameRate.allCases.forEach {
			let tc = Timecode(TCC(d: 0, h: 1, m: 2, s: 3, f: 4),
									 at: $0,
									 limit: ._24hours)
			
			XCTAssertEqual(tc?.days		, 0		, "for \($0)")
			XCTAssertEqual(tc?.hours	, 1		, "for \($0)")
			XCTAssertEqual(tc?.minutes	, 2		, "for \($0)")
			XCTAssertEqual(tc?.seconds	, 3		, "for \($0)")
			XCTAssertEqual(tc?.frames	, 4		, "for \($0)")
			XCTAssertEqual(tc?.subFrames, 0		, "for \($0)")
		}
		
	}
	
}
