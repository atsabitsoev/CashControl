//
//  NewCategoryOrganizationSection.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 29.06.2023.
//

import SwiftUI

struct NewCategoryOrganizationSection: View {
    let allCategories: [ExpensesCategory]
    
    @Binding var superCategoryIndex: Int
    
    
    var body: some View {
        Section("Организация") {
            Picker("Поместить в категорию", selection: $superCategoryIndex) {
                ForEach(0..<allCategories.count, id: \.self) { index in
                    Label {
                        Text(allCategories[index].name).tag(index)
                            .minimumScaleFactor(0.1)
                            .lineLimit(2)
                    } icon: {
                        if let symbol = allCategories[index].symbol {
                            Image(systemName: symbol.name)
                                .foregroundStyle(symbol.color)
                        } else {
                            EmptyView()
                        }
                    }
                    
                }
                Text("Нет").tag(-1)
            }
#if !os(macOS)
            .pickerStyle(NavigationLinkPickerStyle())
#endif
        }
    }
}
