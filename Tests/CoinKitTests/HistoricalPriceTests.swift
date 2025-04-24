//
//  HistoricalPriceTests.swift
//  CoinKit
//
//  Created by Mohammad Komeili on 4/24/25.
//

import XCTest
@testable import CoinKit

final class HistoricalPriceTests: XCTestCase {
    
    func testSampleListHasFourteenEntries() {
        let list = HistoricalPrice.sampleList
        XCTAssertEqual(list.count, 14, "Expected 14 entries in sampleList")
    }
    
    func testSampleListDatesAreInAscendingOrder() {
        let list = HistoricalPrice.sampleList
        let dates = list.map { $0.date }
        let sorted = dates.sorted()
        XCTAssertEqual(dates, sorted, "Dates in sampleList should be in ascending order")
    }
    
    func testSampleListPricesWithinExpectedRange() {
        let list = HistoricalPrice.sampleList
        for price in list {
            XCTAssert(price.price >= 70000 && price.price <= 73000, "Price \(price.price) is out of range")
        }
    }
}
