//
//  ContentView.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 11.06.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            SuperCategoriesList()
                .navigationTitle("Добавить расходы")
                .toolbar(content: {
                    NavigationLink {
                        HistoryView()
                            .navigationTitle("История")
                    } label: {
                        HStack {
                            Text("История")
                            Image(systemName: "chart.bar.doc.horizontal")
                        }
                    }
                    NavigationLink {
                        StatsView()
                            .navigationTitle("Статистика")
                    } label: {
                        HStack {
                            Text("Статистика")
                            Image(systemName: "chart.pie")
                        }
                    }
                })
        }
    }
}


#Preview {
    ContentView()
}
