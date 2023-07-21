//
//  CategoriesService.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 29.06.2023.
//

import SwiftData
import SwiftUI


@Observable
final class CategoriesService {
    static let shared = CategoriesService()
    
    
    private let context: ModelContext? = SwiftDataService.shared.context
    
    
    var allCategories: [ExpensesCategory] {
        let predicate: Predicate<ExpensesCategory> = #Predicate { input in
            !input.children.isEmpty
        }
        let fetchDescriptor = FetchDescriptor<ExpensesCategory>.init(predicate: predicate, sortBy: [SortDescriptor<ExpensesCategory>(\.order)])
        let result: [ExpensesCategory] = (try? context?.fetch(fetchDescriptor)) ?? []
        if result.isEmpty {
            let defaultArray = ExpensesCategory.defaultArray
            for category in defaultArray {
                context?.insert(category)
            }
            do {
                try context?.save()
            } catch {
                print(error.localizedDescription)
            }
            return defaultArray
        }
        return result
    }
    
    
    func addCategory(_ category: ExpensesCategory) {
        context?.insert(category)
        saveContext()
    }
    
    func addSubCategory(_ subCategory: ExpensesCategory, to superCategory: ExpensesCategory) {
        let newSuperCategory: ExpensesCategory = superCategory
        newSuperCategory.children.append(subCategory)
        context?.insert(newSuperCategory)
        saveContext()
    }
    
    func updateCategories(_ newValue: [ExpensesCategory]) {
        newValue.forEach { category in
            context?.insert(category)
            saveContext()
        }
    }
    
    func updateChildren(_ children: [ExpensesCategory], for superCategory: ExpensesCategory) {
        superCategory.children = children
        saveContext()
    }
    
    func removeCategory(_ category: ExpensesCategory) {
        category.isShowingInList = false
        saveContext()
    }
    
    
    private func saveContext() {
        do {
            try context?.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
