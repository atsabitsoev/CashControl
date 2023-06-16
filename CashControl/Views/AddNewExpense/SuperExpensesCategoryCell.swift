//
//  SuperExpensesCategoryCell.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 12.06.2023.
//

import SwiftUI

struct SuperExpensesCategoryCell: View {
    init(category: SuperExpensesCategory,
         isExpanded: Binding<Bool>,
         onSelectCategory: @escaping (ExpensesCategory) -> ()
    ) {
        self.category = category
        self._isExpanded = isExpanded
        self.onSelectCategory = onSelectCategory
    }

    
    @Binding private var isExpanded: Bool
    private let category: SuperExpensesCategory
    private let onSelectCategory: (ExpensesCategory) -> ()
    
    
    var body: some View {
        VStack(alignment: .center) {
            SuperExpensesCategoryView(category: category, isExpanded: $isExpanded)
            if isExpanded {
                ForEach(category.children) { child in
                    ExpensesCategoryButton(title: child.name) {
                        onSelectCategory(child)
                    }
                }
            }
        }
    }
}


#Preview {
    SuperExpensesCategoryCell(
        category: SuperExpensesCategory(
            id: "1",
            name: "Питание",
            sfSymbolName: "fork.knife",
            sfSymbolColor: Color.orange,
            children: [
                ExpensesCategory(
                    id: "1.1",
                    name: "Рестораны"
                ),
                ExpensesCategory(
                    id: "1.2",
                    name: "Продукты питания"
                ),
                ExpensesCategory(
                    id: "1.3",
                    name: "Кофе/чай"
                ),
                ExpensesCategory(
                    id: "1.4",
                    name: "Пикник/заготовки"
                )
            ]
        ),
        isExpanded: .constant(true),
        onSelectCategory: {_ in }
    )
}
