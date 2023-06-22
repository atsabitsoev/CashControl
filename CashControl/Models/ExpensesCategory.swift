//
//  Category.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 11.06.2023.
//

import SwiftUI


struct ExpensesCategory: Identifiable {
    let id: String
    let name: String
}


struct SuperExpensesCategory: Identifiable {
    let id: String
    let name: String
    let sfSymbolName: String
    let sfSymbolColor: Color
    let children: [ExpensesCategory]
    
    
    static let all: [SuperExpensesCategory] = {
        [
            SuperExpensesCategory(
                id: "1",
                name: "Питание",
                sfSymbolName: "fork.knife",
                sfSymbolColor: Color(.displayP3, red: 1.0, green: 0.8, blue: 0.0, opacity: 1),
                children: [
                    ExpensesCategory(
                        id: "1.1",
                        name: "Рестораны"
                    ),
                    ExpensesCategory(
                        id: "1.2",
                        name: "Продукты питания"
                    ),
                    ExpensesCategory(
                        id: "1.3",
                        name: "Кофе/чай"
                    ),
                    ExpensesCategory(
                        id: "1.4",
                        name: "Пикник/заготовки"
                    )
                ]
            ),
            SuperExpensesCategory(
                id: "2",
                name: "Развлечения",
                sfSymbolName: "gamecontroller",
                sfSymbolColor: Color(.displayP3, red: 1.0, green: 0.176, blue: 0.333, opacity: 1),
                children: [
                    ExpensesCategory(
                        id: "2.1",
                        name: "Кино/театр"
                    ),
                    ExpensesCategory(
                        id: "2.2",
                        name: "Концерты/фестивали"
                    ),
                    ExpensesCategory(
                        id: "2.3",
                        name: "Спортивные события"
                    ),
                    ExpensesCategory(
                        id: "2.4",
                        name: "Аттракционы"
                    )
                ]
            ),
            SuperExpensesCategory(
                id: "3",
                name: "Транспорт",
                sfSymbolName: "bus",
                sfSymbolColor: Color(.displayP3, red: 0.0, green: 0.478, blue: 1.0, opacity: 1),
                children: [
                    ExpensesCategory(
                        id: "3.1",
                        name: "Автомобиль"
                    ),
                    ExpensesCategory(
                        id: "3.2",
                        name: "Общественный транспорт"
                    ),
                    ExpensesCategory(
                        id: "3.3",
                        name: "Такси/прокат автомобилей"
                    ),
                    ExpensesCategory(
                        id: "3.4",
                        name: "Парковка/штрафы"
                    )
                ]
            ),
            SuperExpensesCategory(
                id: "4",
                name: "Жилье",
                sfSymbolName: "house",
                sfSymbolColor: Color(.displayP3, red: 0.0, green: 0.863, blue: 0.435, opacity: 1),
                children: [
                    ExpensesCategory(
                        id: "4.1",
                        name: "Аренда/ипотека"
                    ),
                    ExpensesCategory(
                        id: "4.2",
                        name: "Коммунальные услуги"
                    ),
                    ExpensesCategory(
                        id: "4.3",
                        name: "Ремонт/обустройство"
                    )
                ]
            ),
            SuperExpensesCategory(
                id: "5",
                name: "Здоровье и красота",
                sfSymbolName: "cross.case",
                sfSymbolColor: Color(.displayP3, red: 1.0, green: 0.42, blue: 0.506),
                children: [
                    ExpensesCategory(
                        id: "5.1",
                        name: "Медицина"
                    ),
                    ExpensesCategory(
                        id: "5.2",
                        name: "Аптека/лекарства"
                    ),
                    ExpensesCategory(
                        id: "5.3",
                        name: "Спорт/фитнес"
                    ),
                    ExpensesCategory(
                        id: "5.4",
                        name: "Косметика/уход"
                    )
                ]
            ),
            SuperExpensesCategory(
                id: "6",
                name: "Путешествия",
                sfSymbolName: "airplane",
                sfSymbolColor: Color(.displayP3, red: 0.0, green: 0.859, blue: 0.788),
                children: [
                    ExpensesCategory(
                        id: "6.1",
                        name: "Билеты"
                    ),
                    ExpensesCategory(
                        id: "6.2",
                        name: "Проживание"
                    ),
                    ExpensesCategory(
                        id: "6.3",
                        name: "Рестораны/кафе"
                    ),
                    ExpensesCategory(
                        id: "6.4",
                        name: "Достопримечательности"
                    )
                ]
            ),
            SuperExpensesCategory(
                id: "7",
                name: "Образование",
                sfSymbolName: "graduationcap",
                sfSymbolColor: Color(.displayP3, red: 0.757, green: 0.027, blue: 0.655, opacity: 1),
                children: [
                    ExpensesCategory(
                        id: "7.1",
                        name: "Курсы/семинары"
                    ),
                    ExpensesCategory(
                        id: "7.2",
                        name: "Учебники/материалы"
                    ),
                    ExpensesCategory(
                        id: "7.3",
                        name: "Языковые курсы"
                    ),
                    ExpensesCategory(
                        id: "7.4",
                        name: "Учебные поездки"
                    )
                ]
            ),
            SuperExpensesCategory(
                id: "8",
                name: "Другое",
                sfSymbolName: "lightbulb",
                sfSymbolColor: Color(.displayP3, red: 0.557, green: 0.557, blue: 0.557, opacity: 1),
                children: [
                    ExpensesCategory(
                        id: "8.1",
                        name: "Личные расходы"
                    ),
                    ExpensesCategory(
                        id: "8.2",
                        name: "Подарки"
                    ),
                    ExpensesCategory(
                        id: "8.3",
                        name: "Благотворительность"
                    )
                ]
            ),
            SuperExpensesCategory(
                id: "9",
                name: "Ребенок",
                sfSymbolName: "figure.child",
                sfSymbolColor: Color.purple,
                children: [
                    ExpensesCategory(
                        id: "9.1",
                        name: "Памперсы"
                    ),
                    ExpensesCategory(
                        id: "9.2",
                        name: "Одежда"
                    ),
                    ExpensesCategory(
                        id: "9.3",
                        name: "Игрушки"
                    )
                ]
            )
        ]
    }()
}
