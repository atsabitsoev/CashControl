//
//  SuperCategoriesList.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 12.06.2023.
//

import SwiftUI
import Combine
import SwiftData


struct SuperCategoriesList: View {
    private let categories: [SuperExpensesCategory] = SuperExpensesCategory.all
    @State private var expandedSuperCategoryId: String?
    @State private var processingCategory: ExpensesCategory?
    @State private var isShowingSuccessView: Bool = false
    
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 8) {
                    ForEach(categories) { category in
                        SuperExpensesCategoryCell(
                            category: category,
                            isExpanded: Binding<Bool>(
                                get: {
                                    expandedSuperCategoryId == category.id
                                },
                                set: { newValue in
                                    expandedSuperCategoryId = newValue ? category.id : nil
                                }),
                            onSelectCategory: { category in
                                processingCategory = category
                            })
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
            }
            .addNewExpenseAlert(
                processingCategory: $processingCategory,
                onAddAction: { expenseItem in
                    withAnimation {
                        isShowingSuccessView = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                        isShowingSuccessView = false
                    }
                }
            )
            if isShowingSuccessView {
                VStack {
                    Spacer()
                    Spacer()
                    Spacer()
                    GroupBox {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.green)
                        Text("Готово")
                    }
                    .shadow(color: Color.black.opacity(0.3), radius: 60, y: 2)
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    SuperCategoriesList()
}
