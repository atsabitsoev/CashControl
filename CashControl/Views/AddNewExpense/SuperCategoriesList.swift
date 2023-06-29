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
    @State private var categories: [ExpensesCategory] = CategoriesService.shared.allCategories
    @State private var expandedSuperCategoryId: String?
    @State private var processingCategory: ExpensesCategory?
    @State private var isShowingSuccessView: Bool = false
    @State private var isPresentedNewCategory: Bool = false
    
    
    var body: some View {
        ZStack {
            List {
                ForEach($categories) { category in
                    DisclosureGroup(
                        isExpanded: .init(
                            get: { expandedSuperCategoryId == category.id },
                            set: { isExpanded in
                                expandedSuperCategoryId = isExpanded ? category.id : nil })
                    ) {
                        CategoriesListCellExpanded(
                            category: category,
                            processingCategory: $processingCategory
                        )
                        .listRowSeparatorTint(Color.clear)
                    } label: {
                        CategoriesListCell(category: category)
                            .frame(height: 56)
                    }
                    .listRowInsets(EdgeInsets(top: 2, leading: 16, bottom: 2, trailing: 16))
                }
                .onMove(perform: { indices, newOffset in
                    categories.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    categories.remove(atOffsets: indexSet)
                })
                AddCategorySection(addAction: {
                    isPresentedNewCategory = true
                })
            }
    #if !os(macOS)
            .listSectionSpacing(8)
    #endif
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
            .sheet(isPresented: $isPresentedNewCategory, content: {
                NewCategoryView()
            })
            if isShowingSuccessView {
                SuccessView()
            }
        }
    }
}

#Preview {
    SuperCategoriesList()
}
