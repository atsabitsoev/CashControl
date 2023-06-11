//
//  Item.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 11.06.2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
