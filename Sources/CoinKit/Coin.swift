//
//  Coin.swift
//  CoinKit
//
//  Created by Mohammad Komeili on 4/24/25.
//

import Foundation

public struct Coin: Codable, Identifiable, Sendable {
    public let id: String
    public let symbol: String
    public let name: String
    public let description: LocalizedText
    public let image: CoinImage
    public let marketData: MarketData
    public let lastUpdated: String
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, description, image
        case marketData = "market_data"
        case lastUpdated = "last_updated"
    }
}

public struct LocalizedText: Codable, Sendable {
    public let en: String?
}

public struct CoinImage: Codable, Sendable {
    public let thumb: String
    public let small: String
    public let large: String
}

public struct MarketData: Codable, Sendable {
    public let currentPrice: [String: Double]
    public let priceChange24H: Double
    public let priceChangePercentage24H: Double
    
    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
    }
}

// MARK: - Helpers
extension Coin {
    public func toDateString() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = formatter.date(from: lastUpdated) {
            return date.formatted(date: .complete, time: .shortened)
        } else {
            return "Invalid date"
        }
    }
}

// MARK: - Sample Data
#if DEBUG
extension Coin {
    public static var sample: Coin {
        Coin(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            description: LocalizedText(en: "Bitcoin is a decentralized digital currency."),
            image: CoinImage(
                thumb: "https://assets.coingecko.com/coins/images/1/thumb/bitcoin.png",
                small: "https://assets.coingecko.com/coins/images/1/small/bitcoin.png",
                large: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png"
            ),
            marketData: MarketData(currentPrice:
                                    ["usd": 62842.56, "eur": 58610.23, "gbp": 50234.77],
                                   priceChange24H: 192.7989937493,
                                   priceChangePercentage24H: 0.20699),
            lastUpdated: "2025-04-24T07:02:04.003Z"
        )
    }
}
#endif
