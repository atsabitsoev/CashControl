//
//  CategoriesService.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 29.06.2023.
//

import SwiftData


@Observable
final class CategoriesService {
    static let shared = CategoriesService()
    private init() {
        if let container = try? ModelContainer(for: ExpensesCategory.self) {
            context = ModelContext(container)
        } else {
            context = nil
        }
    }
    
    
    private let context: ModelContext?
    
    
    var allCategories: [ExpensesCategory] {
        let fetchDescriptor = FetchDescriptor<ExpensesCategory>.init()
        let result = (try? context?.fetch(fetchDescriptor)) ?? []
        if result.isEmpty {
            let defaultArray = ExpensesCategory.defaultArray
            for category in defaultArray {
                context?.insert(category)
            }
            return defaultArray
        }
        return result
    }
}
