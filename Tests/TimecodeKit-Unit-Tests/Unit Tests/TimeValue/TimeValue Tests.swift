//
//  TimeValue Tests.swift
//  TimecodeUnitTests
//
//  Created by Steffan Andrews on 2020-06-18.
//  Copyright © 2020 Steffan Andrews. All rights reserved.
//

import XCTest
@testable import TimecodeKit

class TimeValue_UT_Tests: XCTestCase {
	
	override func setUp() { }
	override func tearDown() { }
	
	func testMS() {
		
		let time = 50505050.123456789123456789
		
		let ott = TimeValue(ms: time)
		
		XCTAssertEqual(ott.backing,	.ms)
		XCTAssertEqual(ott.ms,		time)
		XCTAssertEqual(ott.seconds,	time / 1000.0)
		
	}
	
	func testSeconds() {
		
		let time = 50505050.123456789123456789
		
		let ott = TimeValue(seconds: time)
		
		XCTAssertEqual(ott.backing,	.seconds)
		XCTAssertEqual(ott.ms,		time * 1000.0)
		XCTAssertEqual(ott.seconds,	time)
		
	}
	
	func testEquatable() {
		
		let ott1 = TimeValue(seconds: 5.5)
		let ott2 = TimeValue(seconds: 5.5)
		
		XCTAssertEqual(ott1, ott2)
		
		let ott3 = TimeValue(seconds: 5.5)
		let ott4 = TimeValue(ms: 5500)
		
		XCTAssertEqual(ott3, ott4)
		
	}
	
	func testComparable() {
		
		let ott1 = TimeValue(seconds: 5.5)
		let ott2 = TimeValue(seconds: 6.0)
		
		XCTAssertTrue(ott1 < ott2)
		XCTAssertTrue(ott2 > ott1)
		
	}
	
}
