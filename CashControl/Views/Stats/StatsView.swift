//
//  StatsView.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 13.06.2023.
//

import SwiftUI
import SwiftData
import Charts
#if !os(macOS)
import UIKit
#endif


struct StatsView: View {
    @Query private var expenseItems: [ExpenseItem]
    @State private var selectedAngle: String?
    @State private var selectedCategoryNameIndex: Int = 0
    private var showBySuperCategory: Bool {
        selectedCategoryNameIndex == 0
    }
    @State private var selectedPeriod: Period = .week
    
    
    private let statsService = StatsService.shared
    
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Picker("Период", selection: $selectedPeriod) {
                    ForEach(Period.allCases) { period in
                        Text(period.title).tag(period)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedPeriod, initial: true) { _, newValue in
                    withAnimation(.bouncy) {
                        if statsService.selectedPeriod != newValue {
                            statsService.selectedPeriod = newValue
                            #if !os(macOS)
                            let generator = UISelectionFeedbackGenerator()
                            generator.selectionChanged()
                            #endif
                        }
                    }
                }
                GroupBox {
                    HStack {
                        Text(statsService.selectedPeriod.totalSpentString)
                            .font(.subheadline)
                        Text(statsService.stats.displayTotalValue())
                            .font(.title2)
                            .bold()
                    }
                }
                OneBarChart(statsService.stats, showBySuperCategory: showBySuperCategory)
                PieChart(stats: statsService.stats, mostExpensed: statsService.mostExpensed, showBySuperCategory: showBySuperCategory)
                HorizontalBarsChart(statsService.stats, showBySuperCategory: showBySuperCategory)
            }
            .padding([.horizontal, .bottom], 16)
            #if os(macOS)
            .padding(.top, 16)
            #endif
        }
        .task(priority: .userInitiated, { await statsService.loadStats() })
        .onDisappear(perform: {
            statsService.currentSuperCategoryName = nil
        })
        .toolbar(content: {
            CategoryPicker(selectedCategoryNameIndex: $selectedCategoryNameIndex)
                .foregroundStyle(.blue)
        })
    }
}
