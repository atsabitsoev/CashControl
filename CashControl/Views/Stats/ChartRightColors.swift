//
//  ChartRightColors.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 15.06.2023.
//

import SwiftUI


struct ChartRightColors: ViewModifier {
    init(stats: [StatItem]) {
        self.stats = stats
    }
    
    
    private let colorsForSubCategories: [Color] = [
        Color.blue,
        Color.green,
        Color.red,
        Color.yellow,
        Color.cyan,
        Color.purple,
        Color.mint,
        Color.pink,
        Color.orange
    ]
    private var stats: [StatItem]
    
    
    func body(content: Content) -> some View {
        content
            .chartForegroundStyleScale(mapping: { legend in
                ExpensesCategory.all
                    .first(where: { $0.name == legend })?
                    .symbol?.color ?? getColor(byLegend: legend) ?? .black
            })
    }
    
    
    /// Для подкатегорий
    private func getColor(byLegend legend: String) -> Color? {
        guard let statIndex = stats.firstIndex(where: { $0.categoryName == legend }) else { return nil }
        let colorIndex = statIndex % colorsForSubCategories.count
        return colorsForSubCategories[colorIndex]
    }
}


extension View {
    func chartRightColors(_ stats: [StatItem]) -> some View {
        return self.modifier(ChartRightColors(stats: stats))
    }
}
