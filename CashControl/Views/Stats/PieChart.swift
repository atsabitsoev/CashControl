//
//  PieChart.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 15.06.2023.
//

import SwiftUI
import Charts

struct PieChart: View {
    init(stats: [StatItem],
         mostExpensed: (categoryName: String, displayValue: String)?,
         showBySuperCategory: Bool) {
        self.stats = stats
        self.mostExpensed = mostExpensed
        self.showBySuperCategory = showBySuperCategory
    }
    
    
    private var stats: [StatItem]
    private var mostExpensed: (categoryName: String, displayValue: String)?
    private var showBySuperCategory: Bool
    
    
    var body: some View {
        Chart(stats) { item in
            SectorMark(angle: .value("Sum", item.value), innerRadius: .ratio(0.9), angularInset: 2)
                .foregroundStyle(
                    by: .value("Category",
                               showBySuperCategory ? item.superCategoryName : item.categoryName)
                )
                .cornerRadius(2)
        }
        .chartLegend(position: TargetDevice.currentDevice == .iPad ? .bottom : .trailing, alignment: .center, spacing: 8)
        .frame(height: 300)
        .chartLegend(.hidden)
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                let frame = geometry[chartProxy.plotAreaFrame]
                VStack {
                    Text(mostExpensed == nil ? "Данных нет" : "Больше всего трат")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                    if let mostExpensed {
                        Text(mostExpensed.categoryName)
                            .font(.title2)
                            .foregroundColor(.primary)
                        Text(mostExpensed.displayValue)
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                    }
                }
                .position(x: frame.midX, y: frame.midY)
            }
        }
        .animation(nil, value: UUID())
        .chartRightColors()
    }
}

#Preview {
    PieChart(stats: ([StatItem(superCategoryName: "Питание", categoryName: "Рестораны", value: 600, color: .red, creationDate: Date()),
                      StatItem(superCategoryName: "Транспорт", categoryName: "Такси", value: 320, color: .blue, creationDate: Date())]),
             mostExpensed: (categoryName: "Питание", displayValue: "600"),
             showBySuperCategory: false)
    .frame(height: 300)
    .padding()
}
