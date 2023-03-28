//
//  TimecodeInterval Tests.swift
//  TimecodeKit • https://github.com/orchetect/TimecodeKit
//  © 2022 Steffan Andrews • Licensed under MIT License
//

#if shouldTestCurrentPlatform

import XCTest
@testable import TimecodeKit

class TimecodeInterval_Tests: XCTestCase {
    override func setUp() { }
    override func tearDown() { }
    
    func testInitA() throws {
        // positive
        
        let intervalTC = try Timecode(.components(m: 1), using: ._24)
        
        let interval = TimecodeInterval(intervalTC)
        
        XCTAssertEqual(interval.absoluteInterval, intervalTC)
        XCTAssertEqual(interval.sign, .plus)
    }
    
    func testInitB() throws {
        // negative
        
        let intervalTC = try Timecode(.components(m: 1), using: ._24)
        
        let interval = TimecodeInterval(intervalTC, .minus)
        
        XCTAssertEqual(interval.absoluteInterval, intervalTC)
        XCTAssertEqual(interval.sign, .minus)
    }
    
    func testInitC() {
        // Timecode.Components can contain negative values;
        // this should not alter the sign however
        
        let intervalTC = Timecode(.components(m: -1), using: ._24, by: .allowingInvalid)
        
        let interval = TimecodeInterval(intervalTC)
        
        XCTAssertEqual(interval.absoluteInterval, intervalTC)
        XCTAssertEqual(interval.sign, .plus)
    }
    
    func testIsNegative() {
        XCTAssertEqual(
            TimecodeInterval(Timecode(.zero, using: ._24))
                .isNegative,
            false
        )
        
        XCTAssertEqual(
            TimecodeInterval(Timecode(.zero, using: ._24), .minus)
                .isNegative,
            true
        )
    }
    
    func testTimecodeA() throws {
        // positive
        
        let intervalTC = try Timecode(.components(m: 1), using: ._24)
        
        let interval = TimecodeInterval(intervalTC)
        
        XCTAssertEqual(interval.flattened(), intervalTC)
    }
    
    func testTimecodeB() throws {
        // negative, wrapping
        
        let intervalTC = try Timecode(.components(m: 1), using: ._24)
        
        let interval = TimecodeInterval(intervalTC, .minus)
        
        XCTAssertEqual(
            interval.flattened(),
            try Timecode(Timecode.Components(h: 23, m: 59, s: 00, f: 00), using: ._24)
        )
    }
    
    func testTimecodeC() throws {
        // positive, wrapping
        
        let intervalTC = Timecode(.components(h: 26), using: ._24, by: .allowingInvalid)
        
        let interval = TimecodeInterval(intervalTC)
        
        XCTAssertEqual(
            interval.flattened(),
            try Timecode(.components(h: 02, m: 00, s: 00, f: 00), using: ._24)
        )
    }
    
    func testTimecodeOffsettingA() throws {
        // positive
        
        let intervalTC = Timecode(.components(m: 1), using: ._24, by: .allowingInvalid)
        
        let interval = TimecodeInterval(intervalTC)
        
        XCTAssertEqual(
            interval.timecode(offsetting: try Timecode(.components(h: 1), using: ._24)),
            try Timecode(.components(h: 01, m: 01, s: 00, f: 00), using: ._24)
        )
    }
    
    func testTimecodeOffsettingB() throws {
        // negative
        
        let intervalTC = Timecode(.components(m: 1), using: ._24, by: .allowingInvalid)
        
        let interval = TimecodeInterval(intervalTC, .minus)
        
        XCTAssertEqual(
            interval.timecode(offsetting: try Timecode(.components(h: 1), using: ._24)),
            try Timecode(.components(h: 00, m: 59, s: 00, f: 00), using: ._24)
        )
    }
    
    func testRealTimeValueA() throws {
        // positive
        
        let intervalTC = try Timecode(.components(h: 1), using: ._24)
        
        let interval = TimecodeInterval(intervalTC)
        
        XCTAssertEqual(interval.realTimeValue, intervalTC.realTimeValue)
    }
    
    func testRealTimeValueB() throws {
        // negative
        
        let intervalTC = try Timecode(.components(h: 1), using: ._24)
        
        let interval = TimecodeInterval(intervalTC, .minus)
        
        XCTAssertEqual(interval.realTimeValue, -intervalTC.realTimeValue)
    }
    
    func testStaticConstructors_Positive() throws {
        let interval: TimecodeInterval = .positive(
            try Timecode(.components(h: 1), using: ._24)
        )
        XCTAssertEqual(
            interval.absoluteInterval,
            try Timecode(.components(h: 1), using: ._24)
        )
        XCTAssertFalse(interval.isNegative)
    }
    
    func testStaticConstructors_Negative() throws {
        let interval: TimecodeInterval = .negative(
            try Timecode(.components(h: 1), using: ._24)
        )
        XCTAssertEqual(
            interval.absoluteInterval,
            try Timecode(.components(h: 1), using: ._24)
        )
        XCTAssertTrue(interval.isNegative)
    }
}

#endif
