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
            String(localized: "1 день")
        case .week:
            String(localized: "1 нед")
        case .month:
            String(localized: "1 мес")
        case .quater:
            String(localized: "3 мес")
        case .year:
            String(localized: "1 год")
        }
    }
    
    var totalSpentString: String {
        switch self {
        case .day:
            return String(localized: "Потрачено сегодня:")
        case .week:
            return String(localized: "Потрачено с начала недели:")
        case .month:
            let formatter = DateFormatter()
            formatter.dateFormat = "LLLL"
            let locale: Locale
            if let identifier = Locale.preferredLanguages.first {
                locale = Locale(identifier: identifier)
            } else {
                locale = Locale.current
            }
            formatter.locale = locale
            let nameOfMonth = formatter.string(from: Date())
            return String(localized: "Потрачено за \(nameOfMonth):")
        case .quater:
            return String(localized: "Потрачено за квартал:")
        case .year:
            return String(localized: "Потрачено за год:")
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
