//
//  StatsService.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 14.06.2023.
//

import SwiftData
import SwiftUI


@Observable
final class StatsService {
    static let shared = StatsService()
    private init() {
        if let container = try? ModelContainer(for: ExpenseItem.self) {
            context = ModelContext(container)
        } else {
            context = nil
        }
    }
    
    
    private let context: ModelContext?
    private var existingCategories: [ExpensesCategory] = []
    private var allStats: [StatItem] = []
    private var groupedStats: [[StatItem]] = []
    
    var expenseItems: [ExpenseItem] = []
    
    var stats: [StatItem] {
        get {
            if let currentSuperCategoryName {
                let group: [StatItem] = groupedStats.first(where: { $0.first?.superCategoryName == currentSuperCategoryName }) ?? []
                let filteredGroup = group.filteredByPeriod(selectedPeriod)
                var result: [StatItem] = []
                for item in filteredGroup {
                    if let index = result.firstIndex(where: { $0.categoryName == item.categoryName }) {
                        let resultElement = result[index]
                        result[index] = StatItem(
                            superCategoryName: resultElement.superCategoryName,
                            categoryName: resultElement.categoryName,
                            value: resultElement.value + item.value,
                            color: resultElement.color,
                            creationDate: item.creationDate
                        )
                    } else {
                        result.append(item)
                    }
                }
                return result
            } else {
                return groupedStats.compactMap { items -> StatItem? in
                    let items = items.filteredByPeriod(selectedPeriod)
                    guard let firstElement = items.first else { return nil }
                    let superCategoryName = firstElement.superCategoryName
                    let categoryName = firstElement.categoryName
                    let sum = items.reduce(0, { $0 + $1.value })
                    let color = firstElement.color
                    return StatItem(superCategoryName: superCategoryName, categoryName: categoryName, value: sum, color: color, creationDate: firstElement.creationDate)
                }
                .filteredByPeriod(selectedPeriod)
            }
        }
    }
    var mostExpensed: (categoryName: String, displayValue: String)? {
        let maxStat = stats.max(by: { $0.value < $1.value })
        if let maxStat {
            let categoryName = currentSuperCategoryName == nil ? maxStat.superCategoryName : maxStat.categoryName
            return (categoryName, maxStat.displayValue)
        } else {
            return nil
        }
    }
    var existingCategoriesNames: [String] { existingCategories.map(\.name) }
    var currentSuperCategoryName: String? = nil
    var selectedPeriod: Period = .week
    
    
    func loadStats() async {
        await loadExpenseItems()
        if Task.isCancelled { return }
        
        let itemsGrouped: [[ExpenseItem]] = Dictionary(grouping: expenseItems, by: { $0.superCategoryId })
            .sorted(by: { $0.key < $1.key })
            .map(\.value)
        let groupedStats: [[StatItem]] = itemsGrouped.map({ items -> [StatItem] in
            return items.compactMap { item -> StatItem? in
                guard let superCategory = item.superCategory,
                      let category = item.category else { return nil }
                return StatItem(
                    superCategoryName: superCategory.name,
                    categoryName: category.name,
                    value: item.sum,
                    color: superCategory.symbol?.color ?? .red,
                    creationDate: item.creationDate
                )
            }
        })
        self.groupedStats = groupedStats
        if Task.isCancelled { return }
        
        setExistingCategories(from: itemsGrouped.compactMap(\.first))
    }
    
    func loadExpenseItems() async {
        let sort = SortDescriptor<ExpenseItem>(\.creationDate, order: .reverse)
        expenseItems = (try? context?.fetch(FetchDescriptor<ExpenseItem>(predicate: nil, sortBy: [sort]))) ?? []
    }
    
    func addItem(_ item: ExpenseItem) async {
        context?.insert(item)
        try? context?.save()
    }
    
    func remove(_ item: ExpenseItem) async {
        expenseItems.removeAll(where: { $0.id == item.id })
        context?.delete(item)
        try? context?.save()
    }
    
    
    private func setExistingCategories(from items: [ExpenseItem]) {
        var result: [ExpensesCategory] = []
        for item in items {
            if let superCategory = item.superCategory,
               !result.contains(where: { $0.id == item.superCategoryId }) {
                result.append(superCategory)
            }
        }
        existingCategories = result
    }
}
