//
//  HorizontalBarsChart.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 15.06.2023.
//

import SwiftUI
import Charts

struct HorizontalBarsChart: View {
    init(_ stats: [StatItem], showBySuperCategory: Bool) {
        self.stats = stats
        self.showBySuperCategory = showBySuperCategory
    }
    
    
    private var showBySuperCategory: Bool
    private var stats: [StatItem]
    
    
    var body: some View {
        Chart(stats) { item in
            BarMark(
                x: .value("Sum", item.value),
                y: .value("Category",
                          showBySuperCategory ? item.superCategoryName : item.categoryName)
            )
                .foregroundStyle(
                    by: .value("Category",
                               showBySuperCategory ? item.superCategoryName : item.categoryName)
                )
                .cornerRadius(2)
                .annotation(position: .trailing, alignment: .center) { context in
                    Text(item.displayValue)
                        .font(.caption)
                }
        }
        .chartLegend(.hidden)
        .chartRightColors()
        .frame(height: 300)
    }
}

#Preview {
    HorizontalBarsChart(
        [StatItem(superCategoryName: "Питание", categoryName: "Рестораны", value: 600, color: .red, creationDate: Date()),
         StatItem(superCategoryName: "Транспорт", categoryName: "Такси", value: 320, color: .blue, creationDate: Date())],
        showBySuperCategory: false
    )
    .frame(height: 80)
    .padding()
}
