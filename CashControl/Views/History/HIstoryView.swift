//
//  HistoryView.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 16.06.2023.
//

import SwiftUI

struct HistoryView: View {
    private let statsService = StatsService.shared
    
    
    var body: some View {
        List {
            ForEach(statsService.expenseItems) { item in
                HStack {
                    if let symbol = item.superCategory?.symbol {
                        Image(systemName: symbol.name)
                            .foregroundStyle(symbol.color)
                            .frame(width: 36)
                    }
                    VStack(alignment: .leading) {
                        Text(item.superCategory?.name ?? "Неизвестно")
                            .font(.headline)
                        Text(item.category?.name ?? "Неизвестно")
                            .font(.caption)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("-" + item.displaySum)
                            .font(.headline)
                            .foregroundStyle(.red)
                        Text(item.displayCreationDate)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .contextMenu(menuItems: {
                    Button(role: .destructive) {
                        Task { await statsService.remove(item) }
                    } label: {
                        Text("Удалить")
                    }
                })
            }
            .onDelete(perform: { indexSet in
                for index in indexSet {
                    Task { await statsService.remove(statsService.expenseItems[index]) }
                }
            })
        }
        .task {
            await statsService.loadExpenseItems()
        }
    }
}

#Preview {
    HistoryView()
}
