//
//  OneBarChart.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 15.06.2023.
//

import SwiftUI
import Charts

struct OneBarChart: View {
    init(_ stats: [StatItem], showBySuperCategory: Bool) {
        self.stats = stats
        self.showBySuperCategory = showBySuperCategory
    }
    
    
    private var showBySuperCategory: Bool
    private var stats: [StatItem]
    
    
    var body: some View {
        Chart {
            ForEach(stats) { item in
                BarMark(x: .value("Sum", item.value), stacking: .normalized)
                    .foregroundStyle(
                        by: .value("Category",
                                   showBySuperCategory ? item.superCategoryName : item.categoryName)
                    )
            }
        }
        .chartRightColors(stats)
        .chartLegend(.visible)
    }
}

#Preview {
    OneBarChart(
        [StatItem(superCategoryName: "Питание", categoryName: "Рестораны", value: 600, color: .red, creationDate: Date()),
         StatItem(superCategoryName: "Транспорт", categoryName: "Такси", value: 320, color: .blue, creationDate: Date())],
        showBySuperCategory: false
    )
    .frame(height: 80)
    .padding()
}
