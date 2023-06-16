//
//  CategoryPicker.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 16.06.2023.
//

import SwiftUI
#if !os(macOS)
import UIKit
#endif

struct CategoryPicker: View {
    init(selectedCategoryNameIndex: Binding<Int>) {
        self._selectedCategoryNameIndex = selectedCategoryNameIndex
    }
    
    
    private let statsService = StatsService.shared
    @Binding private var selectedCategoryNameIndex: Int
    
    
    var body: some View {
        Picker("Показывать:", selection: $selectedCategoryNameIndex) {
            Text("Все категории").tag(0)
            ForEach(0..<statsService.existingCategoriesNames.count, id: \.self) { index in
                Text(statsService.existingCategoriesNames[index]).tag(index + 1)
            }
        }
        .onChange(of: selectedCategoryNameIndex, initial: false, { _, newValue in
            Task {
                let superCategoryName: String?
                if newValue == 0 {
                    superCategoryName = nil
                } else {
                    superCategoryName = statsService.existingCategoriesNames[newValue - 1]
                }
                withAnimation(.bouncy, completionCriteria: .logicallyComplete) {
                    if statsService.currentSuperCategoryName != superCategoryName {
                        statsService.currentSuperCategoryName = superCategoryName
                        #if !os(macOS)
                        let generator = UISelectionFeedbackGenerator()
                        generator.selectionChanged()
                        #endif
                    }
                } completion: {
                    print("hello")
                }
            }
        })
    }
}

#Preview {
    CategoryPicker(selectedCategoryNameIndex: .constant(0))
}
