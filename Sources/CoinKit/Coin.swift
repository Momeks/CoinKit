//
//  File.swift
//  CoinKit
//
//  Created by Mohammad Komeili on 4/24/25.
//

import Foundation

public struct Coin: Codable, Identifiable {
    public let id: String
    public let symbol: String
    public let name: String
    public let description: LocalizedText
    public let image: CoinImage
    public let marketData: MarketData
    public let last_updated: String
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name, description, image
        case marketData = "market_data"
        case last_updated = "lastUpdated"
    }
}

public struct LocalizedText: Codable {
    public let en: String?
}

public struct CoinImage: Codable {
    public let thumb: String
    public let small: String
    public let large: String
}

public struct MarketData: Codable {
    public let currentPrice: [String: Double]
    
    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
    }
}

// MARK: - Helpers
extension Coin {
    public func toDateString() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        if let date = formatter.date(from: last_updated) {
            return date.formatted(date: .complete, time: .shortened)
        } else {
            return "Invalid date"
        }
    }
}

#if DEBUG
// MARK: - Preview
extension Coin {
    public static var preview: Coin {
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
            marketData: MarketData(currentPrice: [
                "usd": 62842.56,
                "eur": 58610.23,
                "gbp": 50234.77
            ]),
            last_updated: "2025-04-24T07:02:04.003Z"
        )
    }
}
#endif
