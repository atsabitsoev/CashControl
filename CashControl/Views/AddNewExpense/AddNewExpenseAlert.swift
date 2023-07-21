//
//  AddNewExpenseAlert.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 12.06.2023.
//

import SwiftUI
import Combine


struct AddNewExpenseAlert: ViewModifier {
    init(processingCategory: Binding<ExpensesCategory?>, onAddAction: @escaping (ExpenseItem) -> ()) {
        self._processingCategory = processingCategory
        self.onAddAction = onAddAction
    }
    
    @Environment(\.modelContext) private var context
    
    private let onAddAction: (ExpenseItem) -> ()
    
    @Binding private var processingCategory: ExpensesCategory?
    @State private var userInput: String = ""
    @State private var userInputSum: Double?
    
    
    func body(content: Content) -> some View {
        content
            .alert("Введите сумму расходов",
                   isPresented: Binding(get: { processingCategory != nil },
                                        set: { _ in })) {
                TextField("Сумма", text: $userInput)
                    .onReceive(Just(userInput)) { newValue in
                        let corrected = newValue.replacingOccurrences(of: ",", with: ".")
                        userInput = corrected
                        userInputSum = Double(corrected)
                    }
#if !os(macOS)
                    .keyboardType(.decimalPad)
#endif
                Button("Отмена") {
                    clearProcess()
                }
                .keyboardShortcut(.cancelAction)
                Button("Добавить") {
                    if let categoryId = processingCategory?.id,
                       let superCategoryId = CategoriesService.shared.allCategories.first(where: {
                           $0.children.contains(where: { $0.id == categoryId })
                       })?.id,
                       let userInputSum {
                        let newExpense = ExpenseItem(categoryId: categoryId,
                                                     superCategoryId: superCategoryId,
                                                     sum: userInputSum)
                        Task { await StatsService.shared.addItem(newExpense) }
                        onAddAction(newExpense)
                        clearProcess()
                    }
#if !os(macOS)
                    let generator = UIImpactFeedbackGenerator(style: .heavy)
                    generator.impactOccurred()
#endif
                }
#if os(macOS)
                .disabled(userInputSum == nil || userInputSum == 0)
#endif
                .keyboardShortcut(.defaultAction)
            }
    }
    
    private func clearProcess() {
        processingCategory = nil
        userInput = ""
        userInputSum = nil
    }
}


extension View {
    func addNewExpenseAlert(processingCategory: Binding<ExpensesCategory?>, onAddAction: @escaping (ExpenseItem) -> ()) -> some View {
        self.modifier(AddNewExpenseAlert(processingCategory: processingCategory, onAddAction: onAddAction))
    }
}
