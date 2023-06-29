//
//  Category.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 11.06.2023.
//

import SwiftUI
import SwiftData


@Model
final class ExpensesCategory: Identifiable {
    struct SFSymbol: Equatable {
        init(name: String, color: Color) {
            self.name = name
            self.color = color
        }
        
        let name: String
        let color: Color
    }
    
    enum CategoryType: Equatable {
        enum CodingKeys: CodingKey {
            case superCategory
            case subCategory
        }
        
        case superCategory(SFSymbol)
        case subCategory
        
        fileprivate var typeString: String {
            switch self {
            case .superCategory:
                "superCategory"
            case .subCategory:
                "subCategory"
            }
        }
    }
    
    
    init(
        id: String,
        name: String,
        type: CategoryType = .subCategory,
        children: [ExpensesCategory]? = nil
    ) {
        self.id = id
        self.name = name
        self.typeString = type.typeString
        self.children = children
        
        if case let .superCategory(symbol) = type {
            self.symbolName = symbol.name
            self.symbolColor = symbol.color
        } else {
            self.symbolName = ""
            self.symbolColor = Color.black
        }
    }
    
    
    let id: String
    var name: String
    private let typeString: String
    private let symbolName: String
    private let symbolColor: Color
    var type: CategoryType {
        switch typeString {
        case "subCategory":
            return .subCategory
        case "superCategory":
            let symbol = SFSymbol(name: symbolName, color: symbolColor)
            return .superCategory(symbol)
        default:
            return .subCategory
        }
    }
    var symbol: SFSymbol? {
        SFSymbol(name: symbolName, color: symbolColor)
    }
    var children: [ExpensesCategory]?
    
    
    static let defaultArray: [ExpensesCategory] = {
        [
            ExpensesCategory(
                id: "1",
                name: "Питание",
                type: .superCategory(
                    SFSymbol(
                        name: "fork.knife",
                        color: Color(.displayP3,
                                     red: 1.0,
                                     green: 0.8,
                                     blue: 0.0,
                                     opacity: 1)
                    )
                ),
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
            ExpensesCategory(
                id: "2",
                name: "Развлечения",
                type: .superCategory(
                    SFSymbol(
                        name: "gamecontroller",
                        color: Color(.displayP3,
                                     red: 1.0,
                                     green: 0.176,
                                     blue: 0.333,
                                     opacity: 1)
                    )
                ),
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
            ExpensesCategory(
                id: "3",
                name: "Транспорт",
                type: .superCategory(
                    SFSymbol(
                        name: "bus",
                        color: Color(.displayP3,
                                     red: 0.0,
                                     green: 0.478,
                                     blue: 1.0,
                                     opacity: 1)
                    )
                ),
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
            ExpensesCategory(
                id: "4",
                name: "Жилье",
                type: .superCategory(
                    SFSymbol(
                        name: "house",
                        color: Color(.displayP3,
                                          red: 0.0,
                                          green: 0.863,
                                          blue: 0.435,
                                          opacity: 1)
                    )
                ),
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
            ExpensesCategory(
                id: "5",
                name: "Здоровье и красота",
                type: .superCategory(
                    SFSymbol(
                        name: "cross.case",
                        color: Color(.displayP3,
                                     red: 1.0,
                                     green: 0.42,
                                     blue: 0.506)
                    )
                ),
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
            ExpensesCategory(
                id: "6",
                name: "Путешествия",
                type: .superCategory(
                    SFSymbol(
                        name: "airplane",
                        color: Color(.displayP3,
                                          red: 0.0,
                                          green: 0.859,
                                          blue: 0.788)
                    )
                ),
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
            ExpensesCategory(
                id: "7",
                name: "Образование",
                type: .superCategory(
                    SFSymbol(
                        name: "graduationcap",
                        color: Color(.displayP3,
                                     red: 0.757,
                                     green: 0.027,
                                     blue: 0.655,
                                     opacity: 1)
                    )
                ),
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
            ExpensesCategory(
                id: "8",
                name: "Другое",
                type: .superCategory(
                    SFSymbol(
                        name: "lightbulb",
                        color: Color(.displayP3,
                                     red: 0.557,
                                     green: 0.557,
                                     blue: 0.557,
                                     opacity: 1)
                    )
                ),
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
            ExpensesCategory(
                id: "9",
                name: "Ребенок",
                type: .superCategory(
                    SFSymbol(
                        name: "figure.child",
                        color: Color.purple
                    )
                ),
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


#if os(iOS)
import UIKit
#elseif os(watchOS)
import WatchKit
#elseif os(macOS)
import AppKit
#endif

fileprivate extension Color {
    #if os(macOS)
    typealias SystemColor = NSColor
    #else
    typealias SystemColor = UIColor
    #endif
    
    var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        #if os(macOS)
        SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        // Note that non RGB color will raise an exception, that I don't now how to catch because it is an Objc exception.
        #else
        guard SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            // Pay attention that the color should be convertible into RGB format
            // Colors using hue, saturation and brightness won't work
            return nil
        }
        #endif
        
        return (r, g, b, a)
    }
}

extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case red, green, blue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let r = try container.decode(Double.self, forKey: .red)
        let g = try container.decode(Double.self, forKey: .green)
        let b = try container.decode(Double.self, forKey: .blue)
        
        self.init(red: r, green: g, blue: b)
    }

    public func encode(to encoder: Encoder) throws {
        guard let colorComponents = self.colorComponents else {
            return
        }
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(colorComponents.red, forKey: .red)
        try container.encode(colorComponents.green, forKey: .green)
        try container.encode(colorComponents.blue, forKey: .blue)
    }
}
