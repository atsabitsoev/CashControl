//
//  Category.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 11.06.2023.
//

import SwiftUI
import SwiftData
#if os(iOS)
import UIKit
#elseif os(watchOS)
import WatchKit
#elseif os(macOS)
import AppKit
#endif


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
        order: Int,
        canAddExpenses: Bool = true,
        children: [ExpensesCategory] = []
    ) {
        self.id = id
        self.name = name
        self.typeString = type.typeString
        self.order = order
        self.isShowingInList = canAddExpenses
        self.children = children
        
        if case let .superCategory(symbol) = type {
            self.symbolName = symbol.name
            self.symbolColor = symbol.color.toHex()
        } else {
            self.symbolName = ""
            self.symbolColor = Color.clear.toHex()
        }
    }
    
    
    let id: String
    var name: String
    private let typeString: String
    private let symbolName: String
    private let symbolColor: String
    var order: Int
    var isShowingInList: Bool
    var type: CategoryType {
        switch typeString {
        case "subCategory":
            return .subCategory
        case "superCategory":
            if let symbol = self.symbol {
                return .superCategory(symbol)
            } else {
                return .subCategory
            }
        default:
            return .subCategory
        }
    }
    var symbol: SFSymbol? {
        guard symbolColor != Color.clear.toHex() else { return nil }
        return SFSymbol(name: symbolName, color: Color.fromHex(symbolColor))
    }
    @Relationship(.cascade) var children: [ExpensesCategory]
    
    
    static let defaultArray: [ExpensesCategory] = {
        [
            ExpensesCategory(
                id: UUID().uuidString,
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
                order: 0,
                children: [
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Рестораны",
                        order: 0
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Продукты питания",
                        order: 1
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Кофе/чай",
                        order: 2
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Пикник/заготовки",
                        order: 3
                    )
                ]
            ),
            ExpensesCategory(
                id: UUID().uuidString,
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
                order: 1,
                children: [
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Кино/театр",
                        order: 0
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Концерты/фестивали",
                        order: 1
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Спортивные события",
                        order: 2
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Аттракционы",
                        order: 3
                    )
                ]
            ),
            ExpensesCategory(
                id: UUID().uuidString,
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
                order: 2,
                children: [
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Автомобиль",
                        order: 0
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Общественный транспорт",
                        order: 1
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Такси/прокат автомобилей",
                        order: 2
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Парковка/штрафы",
                        order: 3
                    )
                ]
            ),
            ExpensesCategory(
                id: UUID().uuidString,
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
                order: 3,
                children: [
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Аренда/ипотека",
                        order: 0
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Коммунальные услуги",
                        order: 1
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Ремонт/обустройство",
                        order: 2
                    )
                ]
            ),
            ExpensesCategory(
                id: UUID().uuidString,
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
                order: 4,
                children: [
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Медицина",
                        order: 0
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Аптека/лекарства",
                        order: 1
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Спорт/фитнес",
                        order: 2
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Косметика/уход",
                        order: 3
                    )
                ]
            ),
            ExpensesCategory(
                id: UUID().uuidString,
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
                order: 5,
                children: [
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Билеты",
                        order: 0
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Проживание",
                        order: 1
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Рестораны/кафе",
                        order: 2
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Достопримечательности",
                        order: 3
                    )
                ]
            ),
            ExpensesCategory(
                id: UUID().uuidString,
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
                order: 6,
                children: [
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Курсы/семинары",
                        order: 0
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Учебники/материалы",
                        order: 1
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Языковые курсы",
                        order: 2
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Учебные поездки",
                        order: 3
                    )
                ]
            ),
            ExpensesCategory(
                id: UUID().uuidString,
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
                order: 7,
                children: [
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Личные расходы",
                        order: 0
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Подарки",
                        order: 1
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Благотворительность",
                        order: 2
                    )
                ]
            ),
            ExpensesCategory(
                id: UUID().uuidString,
                name: "Ребенок",
                type: .superCategory(
                    SFSymbol(
                        name: "figure.child",
                        color: Color.purple
                    )
                ),
                order: 8,
                children: [
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Памперсы",
                        order: 0
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Одежда",
                        order: 1
                    ),
                    ExpensesCategory(
                        id: UUID().uuidString,
                        name: "Игрушки",
                        order: 2
                    )
                ]
            )
        ]
    }()
}


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


fileprivate extension Color {
    // Преобразование Color в Hex-строку
    func toHex() -> String {
        #if os(iOS)
        let color = self.cgColor ?? UIColor(self).cgColor
        #else
        let color = self.cgColor ?? NSColor(self).cgColor
        #endif
        if let components = color.components {
            let r = components[0]
            let g = components[1]
            let b = components[2]
            let hex = String(format: "#%02lX%02lX%02lX", lroundf(Float(r) * 255), lroundf(Float(g) * 255), lroundf(Float(b) * 255))
            return hex
        }
        return ""
    }
    
    // Создание Color из Hex-строки
    static func fromHex(_ hex: String) -> Color {
        var formattedHex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if formattedHex.hasPrefix("#") {
            formattedHex.remove(at: formattedHex.startIndex)
        }
        if formattedHex.count == 6 {
            var rgbValue: UInt64 = 0
            Scanner(string: formattedHex).scanHexInt64(&rgbValue)
            let r = Double((rgbValue & 0xFF0000) >> 16) / 255.0
            let g = Double((rgbValue & 0x00FF00) >> 8) / 255.0
            let b = Double(rgbValue & 0x0000FF) / 255.0
            return Color(red: r, green: g, blue: b)
        }
        return Color.clear
    }
}
