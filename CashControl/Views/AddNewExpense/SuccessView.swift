//
//  SuccessView.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 23.06.2023.
//

import SwiftUI

struct SuccessView: View {
    var body: some View {
        VStack {
            Spacer()
            Spacer()
            Spacer()
            GroupBox {
                Image(systemName: "checkmark.circle")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.green)
                Text("Готово")
            }
            .shadow(color: Color.black.opacity(0.3), radius: 60, y: 2)
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
        }
    }
}


#Preview {
    SuccessView()
}
