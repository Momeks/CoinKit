//
//  MarketChart.swift
//  CoinKit
//
//  Created by Mohammad Komeili on 4/24/25.
//

import Foundation

public struct MarketChart: Codable, Sendable {
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
        let calendar = Calendar.current
        var dailyPrices: [DateComponents: HistoricalPrice] = [:]
        
        for entry in prices {
            guard entry.count == 2 else { continue }
            let timestamp = entry[0] / 1000.0
            let date = Date(timeIntervalSince1970: timestamp)
            let price = entry[1]
            let day = calendar.dateComponents([.year, .month, .day], from: date)
            
            dailyPrices[day] = HistoricalPrice(date: date, price: price)
        }
        
        return dailyPrices
            .values
            .sorted(by: { $0.date > $1.date })
    }
}

// MARK: - Sample Data
#if DEBUG
extension HistoricalPrice {
    public static var sample: HistoricalPrice {
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
