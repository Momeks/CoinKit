//
//  HistoricalData.swift
//  CoinKit
//
//  Created by Momeks on 25.02.26.
//

import Foundation

public struct HistoricalData: Codable, Identifiable, Sendable {
    public let id: String
    public let symbol: String
    public let name: String
    public let marketData: MarketData?
    
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
        case marketData = "market_data"
    }
    
    public struct MarketData: Codable, Sendable {
        public let currentPrice: [String: Double]
        
        enum CodingKeys: String, CodingKey {
            case currentPrice = "current_price"
        }
    }
}

// MARK: - Sample Data
#if DEBUG
extension HistoricalData {
    public static let sample: HistoricalData = HistoricalData(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        marketData: MarketData(
            currentPrice: [
                "usd": 93605.45,
                "eur": 82601.29
            ]
        )
    )
}
#endif
