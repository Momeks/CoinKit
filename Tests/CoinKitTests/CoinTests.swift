//
//  CoinTests.swift
//  CoinKit
//
//  Created by Mohammad Komeili on 4/24/25.
//

import XCTest
@testable import CoinKit

final class CoinTests: XCTestCase {
    
    func testCoinPreviewDataIsValid() {
        let coin = Coin.sample
        
        XCTAssertEqual(coin.id, "bitcoin")
        XCTAssertEqual(coin.symbol, "btc")
        XCTAssertEqual(coin.name, "Bitcoin")
        XCTAssertEqual(coin.description.en, "Bitcoin is a decentralized digital currency.")
        XCTAssertEqual(coin.image.thumb, "https://assets.coingecko.com/coins/images/1/thumb/bitcoin.png")
        XCTAssertEqual(coin.marketData.currentPrice["usd"], 62842.56)
    }
    
    func testToDateStringReturnsFormattedDate() {
        let coin = Coin.sample
        let dateString = coin.toDateString()
        
        XCTAssertFalse(dateString.isEmpty)
        XCTAssertNotEqual(dateString, "Invalid date")
    }
    
    func testToDateStringHandlesInvalidDate() {
        var coin = Coin.sample
        coin = Coin(
            id: coin.id,
            symbol: coin.symbol,
            name: coin.name,
            description: coin.description,
            image: coin.image,
            marketData: coin.marketData,
            lastUpdated: "invalid-date"
        )
        
        let dateString = coin.toDateString()
        XCTAssertEqual(dateString, "Invalid date")
    }
    
    func testCurrentPriceMissingCurrencyReturnsNil() {
        let coin = Coin.sample
        let nonexistentCurrencyPrice = coin.marketData.currentPrice["rial"]  // assuming "Iranian rial" is not in preview data

        XCTAssertNil(nonexistentCurrencyPrice, "Expected nil for a currency not present in currentPrice")
    }
}
