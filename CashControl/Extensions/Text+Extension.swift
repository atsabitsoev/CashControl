//
//  Text+Extension.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 23.06.2023.
//

import SwiftUI


extension Text {
    func adaptiveTextColor(background: Color) -> Text {
        self.foregroundStyle(background.isLight() ? .black : .white)
    }
}
