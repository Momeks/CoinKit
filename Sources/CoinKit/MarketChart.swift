//
//  MarketChart.swift
//  CoinKit
//
//  Created by Mohammad Komeili on 4/24/25.
//

import Foundation

public struct MarketChart: Codable {
    public let prices: [[Double]]  // [timestamp, price] in milliseconds
}

public struct HistoricalPrice: Identifiable {
    public let id = UUID()
    public let date: Date
    public let price: Double
}

// MARK: - Helpers
extension MarketChart {
    public func toHistoricalPrices() -> [HistoricalPrice] {
        return prices.compactMap { entry in
            guard entry.count == 2 else { return nil }
            let date = Date(timeIntervalSince1970: entry[0] / 1000.0)
            return HistoricalPrice(date: date, price: entry[1])
        }
    }
}

#if DEBUG
// MARK: - Preview
extension HistoricalPrice {
    public static var preview: HistoricalPrice {
        HistoricalPrice(
            date: Date(timeIntervalSince1970: 1713907200),  // April 24, 2024
            price: 62842.56
        )
    }
    
    /// A sample list of HistoricalPrice values over the last 14 days.
    public static var sampleList: [HistoricalPrice] {
        (0..<14).map { i in
            HistoricalPrice(
                date: Calendar.current.date(byAdding: .day, value: -i, to: Date()) ?? Date(),
                price: Double.random(in: 70000...73000)
            )
        }.reversed()
    }
}
#endif
