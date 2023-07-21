//
//  NewCategorySubcategoriesSection.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 29.06.2023.
//

import SwiftUI

struct NewCategorySubcategoriesSection: View {
    let allSymbols: [(String, String)]
    
    @Binding var children: [ExpensesCategory]
    @FocusState var focusedField: NewCategoryView.FocusedField?
    
    
    var body: some View {
        Section("Подкатегории") {
            ForEach(children, id: \.id) { child in
                TextField("Название подкатегории", text: .init(get: {
                    children.first(where: { $0.id == child.id })?.name ?? "Hello"
                }, set: { newValue in
                    if let index = children.firstIndex(where: { $0.id == child.id }) {
                        children[index] = ExpensesCategory(id: child.id, name: newValue, order: child.order)
                    }
                }))
                .submitLabel(.done)
                .onSubmit({
                    children.removeAll(where: { $0.name.isEmpty })
                })
                .focused($focusedField, equals: .subCategoryName(categoryId: child.id))
                .onAppear {
                    focusedField = .subCategoryName(categoryId: child.id)
                }
            }
            .onDelete(perform: { indexSet in
                children.remove(atOffsets: indexSet)
            })
            Button(action: {
                children.append(ExpensesCategory(id: UUID().uuidString, name: "", order: children.count))
            },
                   label: {
                Text("Добавить подкатегорию")
            })
            .disabled(children.contains(where: { $0.name.isEmpty }))
        }
    }
}
