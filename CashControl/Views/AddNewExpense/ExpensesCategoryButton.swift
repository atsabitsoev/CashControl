//
//  ExpensesCategoryButton.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 12.06.2023.
//

import SwiftUI

struct ExpensesCategoryButton: View {
    init(title: String, action: @escaping () -> ()) {
        self.title = title
        self.action = action
    }
    
    private let title: String
    private let action: () -> ()
    
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .frame(height: 50)
                .padding(.horizontal, 16)
        }
        .transition(.opacity)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .background(content: {
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.regularMaterial)
        })
    }
}

#Preview {
    ExpensesCategoryButton(title: "Рестораны", action: {})
}
