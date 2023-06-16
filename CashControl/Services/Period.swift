//
//  Period.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 16.06.2023.
//

import Foundation

enum Period: CaseIterable, Identifiable {
    case day
    case week
    case month
    case quater
    case year
    
    
    var title: String {
        switch self {
        case .day:
            "1 день"
        case .week:
            "1 нед"
        case .month:
            "1 мес"
        case .quater:
            "3 мес"
        case .year:
            "1 год"
        }
    }
    
    var totalSpentString: String {
        switch self {
        case .day:
            "Потрачено за день:"
        case .week:
            "Потрачено за неделю:"
        case .month:
            "Потрачено за месяц:"
        case .quater:
            "Потрачено за квартал:"
        case .year:
            "Потрачено за год:"
        }
    }
    
    var id: String { title }
}


extension Array<StatItem> {
    func filteredByPeriod(_ period: Period) -> Array<StatItem> {
        let calendar = Calendar.current
        let currentDate = Date()
        switch period {
        case .day:
            return self.filter({ return calendar.dateComponents([.day, .month, .year], from: $0.creationDate) == calendar.dateComponents([.day, .month, .year], from: currentDate) })
        case .week:
            return self.filter({ calendar.dateComponents([.weekOfYear, .year], from: $0.creationDate) == calendar.dateComponents([.weekOfYear, .year], from: currentDate) })
        case .month:
            return self.filter({ calendar.dateComponents([.month, .year], from: $0.creationDate) == calendar.dateComponents([.month, .year], from: currentDate) })
        case .quater:
            return self.filter({ calendar.dateComponents([.quarter, .year], from: $0.creationDate) == calendar.dateComponents([.quarter, .year], from: currentDate) })
        case .year:
            return self.filter({ calendar.dateComponents([.year], from: $0.creationDate) == calendar.dateComponents([.year], from: currentDate) })
        }
    }
}
