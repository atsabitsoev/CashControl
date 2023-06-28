//
//  AddCategorySection.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 28.06.2023.
//

import SwiftUI

struct AddCategorySection: View {
    let addAction: () -> Void
    
    
    var body: some View {
        Section {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.clear)
                Button {
                    addAction()
                } label: {
                    Label {
                        Text("Добавить категорию")
                    } icon: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
        }
    }
}

#Preview {
    AddCategorySection(addAction: {})
}
