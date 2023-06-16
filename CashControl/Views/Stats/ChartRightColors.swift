//
//  ChartRightColors.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 15.06.2023.
//

import SwiftUI


struct ChartRightColors: ViewModifier {
    private let subCategoriesColors: [String: Color] = [
        "Рестораны": Color.blue,
        "Продукты питания": Color.green,
        "Кофе/чай": Color.yellow,
        "Пикник/заготовки": Color.purple,
        
        "Кино/театр": Color.blue,
        "Концерты/фестивали": Color.green,
        "Спортивные события": Color.yellow,
        "Аттракционы": Color.purple,
        
        "Автомобиль": Color.blue,
        "Общественный транспорт": Color.green,
        "Такси/прокат автомобилей": Color.yellow,
        "Парковка/штрафы": Color.purple,
        
        "Аренда/ипотека": Color.blue,
        "Коммунальные услуги": Color.green,
        "Ремонт/обустройство": Color.yellow,
        
        "Медицина": Color.blue,
        "Аптека/лекарства": Color.green,
        "Спорт/фитнес": Color.yellow,
        "Косметика/уход": Color.purple,
        
        "Билеты": Color.blue,
        "Проживание": Color.green,
        "Рестораны/кафе": Color.yellow,
        "Достопримечательности": Color.purple,
        
        "Курсы/семинары": Color.blue,
        "Учебники/материалы": Color.green,
        "Языковые курсы": Color.yellow,
        "Учебные поездки": Color.purple,
        
        "Личные расходы": Color.green,
        "Подарки": Color.yellow,
        "Благотворительность": Color.purple
    ]
    
    
    func body(content: Content) -> some View {
        content
            .chartForegroundStyleScale(mapping: { legend in
                SuperExpensesCategory.all
                    .first(where: { $0.name == legend })?
                    .sfSymbolColor ?? subCategoriesColors[legend] ?? .black
            })
    }
}


extension View {
    func chartRightColors() -> some View {
        return self.modifier(ChartRightColors())
    }
}
