//
//  SwiftDataService.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 29.06.2023.
//

import SwiftData


final class SwiftDataService {
    static let shared = SwiftDataService()
    
    
    private init() {
        if let container = try? ModelContainer(for: [ExpenseItem.self, ExpensesCategory.self]) {
            context = ModelContext(container)
        } else {
            context = nil
        }
    }
    
    
    let context: ModelContext?
}
