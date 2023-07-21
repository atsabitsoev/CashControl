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
    
    
    private var sortedAndFilteredCategories: [ExpensesCategory] {
        categories.filter(\.isShowingInList).sorted(by: { $0.order < $1.order })
    }
    
    
    var body: some View {
        ZStack {
            List {
                ForEach(sortedAndFilteredCategories) { category in
                    DisclosureGroup(
                        isExpanded: .init(
                            get: { expandedSuperCategoryId == category.id },
                            set: { isExpanded in
                                expandedSuperCategoryId = isExpanded ? category.id : nil })
                    ) {
                        CategoriesListCellExpanded(
                            category: .constant(category),
                            processingCategory: $processingCategory
                        )
                        .listRowSeparatorTint(Color.clear)
                    } label: {
                        CategoriesListCell(category: .constant(category))
                            .frame(height: 56)
                    }
                    .listRowInsets(EdgeInsets(top: 2, leading: 16, bottom: 2, trailing: 16))
                }
                .onMove(perform: { indices, newOffset in
                    var sortedAndFilteredCategories: [ExpensesCategory] = self.sortedAndFilteredCategories
                    sortedAndFilteredCategories.move(fromOffsets: indices, toOffset: newOffset)
                    let resultCategories: [ExpensesCategory] = sortedAndFilteredCategories.enumerated().map { (index, category) -> ExpensesCategory in
                        let category = category
                        category.order = index
                        return category
                    }
                    CategoriesService.shared.updateCategories(resultCategories)
                    categories = CategoriesService.shared.allCategories
                })
                .onDelete(perform: { indexSet in
                    var sortedAndFilteredCategories = self.sortedAndFilteredCategories
                    indexSet.forEach { index in
                        CategoriesService.shared.removeCategory(sortedAndFilteredCategories[index])
                    }
                    sortedAndFilteredCategories.remove(atOffsets: indexSet)
                    categories = CategoriesService.shared.allCategories
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
                NewCategoryView(isPresented: $isPresentedNewCategory)
            })
            .onChange(of: isPresentedNewCategory, initial: false) { oldValue, newValue in
                if oldValue && !newValue {
                    categories = CategoriesService.shared.allCategories
                }
            }
            if isShowingSuccessView {
                SuccessView()
            }
        }
    }
}

#Preview {
    SuperCategoriesList()
}
