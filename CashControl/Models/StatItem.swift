//
//  StatItem.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 14.06.2023.
//

import SwiftUI


struct StatItem: Identifiable, Equatable {
    static fileprivate let sumFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.groupingSize = 3
        formatter.groupingSeparator = " "
        formatter.allowsFloats = true
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    
    let id = UUID()
    let superCategoryName: String
    let categoryName: String
    let value: Double
    let color: Color
    let creationDate: Date
    
    
    var displayValue: String {
        StatItem.sumFormatter.string(from: NSNumber(floatLiteral: value)) ?? "0"
    }
}


extension Array<StatItem> {
    func displayTotalValue() -> String {
        let totalValue = reduce(0, { $0 + $1.value })
        return StatItem.sumFormatter.string(from: NSNumber(floatLiteral: totalValue)) ?? "0"
    }
}
