//
//  SuperCategoriesListCell.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 23.06.2023.
//

import SwiftUI

struct CategoriesListCell: View {
    @Binding var category: ExpensesCategory
    
    
    var body: some View {
        Label {
            Text(category.name)
        } icon: {
            if let symbol = category.symbol {
                Image(systemName: symbol.name)
                    .foregroundStyle(symbol.color)
            } else {
                EmptyView()
            }
        }
    }
}
