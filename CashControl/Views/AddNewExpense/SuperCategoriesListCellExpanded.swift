//
//  SuperCategoriesListCellExpanded.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 23.06.2023.
//

import SwiftUI

struct CategoriesListCellExpanded: View {
    @Binding var category: ExpensesCategory
    @Binding var processingCategory: ExpensesCategory?
    
    
    private var sortedAndFilteredChildren: [ExpensesCategory] {
        category.children.filter(\.isShowingInList).sorted(by: { $0.order < $1.order })
    }
    
    
    var body: some View {
        ForEach(sortedAndFilteredChildren) { childCategory in
                Button {
                    processingCategory = childCategory
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(category.symbol?.color ?? .blue)
                        Text(childCategory.name)
                            .adaptiveTextColor(background: category.symbol?.color ?? .white)
                    }
                }
            .buttonStyle(PlainButtonStyle())
        }
        .onMove(perform: { indices, newOffset in
            var sortedAndFilteredChildren = self.sortedAndFilteredChildren
            sortedAndFilteredChildren.move(fromOffsets: indices, toOffset: newOffset)
            let resultChildren = sortedAndFilteredChildren.enumerated().map { (index, child) -> ExpensesCategory in
                let child = child
                child.order = index
                return child
            }
            category.children = resultChildren
            CategoriesService.shared.updateChildren(resultChildren, for: category)
        })
        .onDelete(perform: { indexSet in
            indexSet.forEach { index in
                CategoriesService.shared.removeCategory(sortedAndFilteredChildren[index])
            }
        })
    }
}
