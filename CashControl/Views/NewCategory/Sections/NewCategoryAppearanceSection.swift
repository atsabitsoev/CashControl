//
//  NewCategoryAppearanceSection.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 29.06.2023.
//

import SwiftUI

struct NewCategoryAppearanceSection: View {
    let allSymbols: [(String, String)]
    
    @Binding var name: String
    @Binding var color: Color
    @Binding var superCategoryIndex: Int
    @Binding var sfSymbolName: String
    @FocusState var focusedField: NewCategoryView.FocusedField?
    
    
    var body: some View {
        Section("Оформление") {
            TextField(text: $name) {
                Text("Название категории")
            }
            .focused($focusedField, equals: .categoryName)
            if superCategoryIndex == -1 {
                ColorPicker("Цвет", selection: $color)
                Picker("Символ", selection: $sfSymbolName, content: {
                    ForEach(allSymbols, id: \.0) { symbol in
#if os(macOS)
                        HStack {
                            Text(symbol.1)
                            Image(systemName: symbol.0)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 24)
                                .foregroundStyle(color)
                        }
                        .tag(symbol.0)
#else
                        Label {
                            Text(symbol.1)
                        } icon: {
                            Image(systemName: symbol.0)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 24)
                                .foregroundStyle(color)
                        }
                        .tag(symbol.0)
#endif
                    }
                })
#if !os(macOS)
                .pickerStyle(NavigationLinkPickerStyle())
#endif
            }
        }
    }
}
