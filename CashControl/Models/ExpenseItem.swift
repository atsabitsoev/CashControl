//
//  ExpenseItem.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 12.06.2023.
//

import SwiftData
import Foundation

@Model
final class ExpenseItem {
    static private let sumFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.groupingSize = 3
        formatter.groupingSeparator = " "
        formatter.allowsFloats = true
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    static private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y"
        let locale: Locale
        if let identifier = Locale.preferredLanguages.first {
            locale = Locale(identifier: identifier)
        } else {
            locale = Locale.current
        }
        formatter.locale = locale
        return formatter
    }()
    
    
    init(categoryId: String, superCategoryId: String, sum: Double) {
        self.categoryId = categoryId
        self.superCategoryId = superCategoryId
        self.sum = sum
        self.creationDate = Date()
    }
    
    
    let categoryId: String
    let superCategoryId: String
    let sum: Double
    let creationDate: Date
    
    
    var displaySum: String {
        ExpenseItem.sumFormatter.string(from: NSNumber(floatLiteral: sum)) ?? "0"
    }
    
    var category: ExpensesCategory? {
        SuperExpensesCategory.all.flatMap(\.children).first(where: { $0.id == categoryId })
    }
    
    var superCategory: SuperExpensesCategory? {
        SuperExpensesCategory.all.first(where: { $0.id == superCategoryId })
    }
    
    var displayCreationDate: String {
        return ExpenseItem.dateFormatter.string(from: creationDate)
    }
}
