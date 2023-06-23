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
    
    
    var body: some View {
        ForEach(category.children ?? []) { childCategory in
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
            category.children?.move(fromOffsets: indices, toOffset: newOffset)
        })
    }
}
