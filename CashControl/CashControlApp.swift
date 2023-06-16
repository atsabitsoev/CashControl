//
//  CashControlApp.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 11.06.2023.
//

import SwiftUI
import SwiftData

@main
struct CashControlApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self, isUndoEnabled: true)
    }
}
