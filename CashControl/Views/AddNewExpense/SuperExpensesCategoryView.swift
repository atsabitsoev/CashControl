//
//  SuperExpensesCategoryView.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 12.06.2023.
//

import SwiftUI

struct SuperExpensesCategoryView: View {
    init(category: SuperExpensesCategory, isExpanded: Binding<Bool>) {
        self.category = category
        self._isExpanded = isExpanded
    }

    
    @Binding private var isExpanded: Bool
    private let category: SuperExpensesCategory
    
    
    var body: some View {
        Button {
            withAnimation {
                isExpanded.toggle()
                #if !os(macOS)
                let generator = UISelectionFeedbackGenerator()
                generator.selectionChanged()
                #endif
            }
        } label: {
            HStack {
                Label(title: {
                    Text(category.name)
                        .font(.headline)
                }, icon: {
                    Image(systemName: category.sfSymbolName)
                        .foregroundStyle(category.sfSymbolColor)
                })
                Spacer()
                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                    .contentTransition(.symbolEffect)
            }
            .frame(height: 80)
            .padding(.horizontal, 16)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .background(content: {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.regularMaterial)
        })
        .tint(.primary)
    }
}


#Preview {
    SuperExpensesCategoryView(
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
        isExpanded: .constant(true)
    )
}
