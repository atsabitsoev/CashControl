//
//  NewCategoryView.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 28.06.2023.
//

import SwiftUI

struct NewCategoryView: View {
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    enum FocusedField: Hashable {
        case categoryName
        case subCategoryName(categoryId: String)
    }
    
    
    private let allCategories: [ExpensesCategory] = CategoriesService.shared.allCategories
    private let allSymbols: [(String, String)] = [
        ("house", String(localized: "Жилье")),
        ("car", String(localized: "Автомобиль")),
        ("fork.knife", String(localized: "Еда")),
        ("cup.and.saucer", String(localized: "Кофе")),
        ("tshirt", String(localized: "Одежда")),
        ("shoe", String(localized: "Обувь")),
        ("bag", String(localized: "Сумка")),
        ("dollarsign", String(localized: "Деньги")),
        ("heart", String(localized: "Здоровье")),
        ("globe", String(localized: "Путешествия")),
        ("book", String(localized: "Образование")),
        ("music.note", String(localized: "Музыка")),
        ("camera", String(localized: "Фотография")),
        ("film", String(localized: "Кино")),
        ("gamecontroller", String(localized: "Игры")),
        ("bicycle", String(localized: "Фитнес")),
        ("pencil", String(localized: "Творчество")),
        ("leaf", String(localized: "Экология")),
        ("bed.double", String(localized: "Отдых")),
        ("gift", String(localized: "Подарки")),
        ("hourglass", String(localized: "Время")),
        ("paintbrush", String(localized: "Искусство")),
        ("cloud", String(localized: "Облако")),
        ("sun.max", String(localized: "Солнце")),
        ("moon.stars", String(localized: "Луна и звезды")),
        ("creditcard", String(localized: "Кредитная карта")),
        ("train.side.front.car", String(localized: "Поезд")),
        ("airplane", String(localized: "Самолет")),
        ("bus", String(localized: "Автобус")),
        ("lightbulb", String(localized: "Лампочка")),
        ("graduationcap", String(localized: "Шапочка выпускника")),
        ("mic", String(localized: "Микрофон")),
        ("guitars", String(localized: "Гитары")),
        ("gauge", String(localized: "Измерение")),
        ("flame", String(localized: "Огонь")),
        ("dumbbell", String(localized: "Спорт")),
        ("camera.aperture", String(localized: "Диафрагма")),
        ("headphones", String(localized: "Наушники")),
        ("film", String(localized: "Пленка")),
        ("airpods", String(localized: "Беспроводные наушники")),
        ("homekit", String(localized: "Умный дом")),
        ("desktopcomputer", String(localized: "Компьютер")),
        ("laptopcomputer", String(localized: "Ноутбук")),
        ("ipad.gen2.landscape", String(localized: "Планшет")),
        ("keyboard", String(localized: "Клавиатура")),
        ("printer", String(localized: "Принтер")),
        ("scissors", String(localized: "Ножницы")),
        ("pawprint", String(localized: "Лапа")),
        ("shippingbox", String(localized: "Коробка"))
    ].sorted(by: { $0.1 < $1.1 })
    
    
    @State private var name: String = ""
    @State private var color: Color = .orange
    @State private var superCategoryIndex: Int = -1
    @State private var children: [ExpensesCategory] = []
    @State private var sfSymbolName: String = "shippingbox"
    @Binding private var isPresented: Bool
    @FocusState private var focusedField: FocusedField?
    
    
    var body: some View {
        NavigationStack {
            Form {
                NewCategoryOrganizationSection(
                    allCategories: allCategories,
                    superCategoryIndex: $superCategoryIndex
                )
                NewCategoryAppearanceSection(
                    allSymbols: allSymbols,
                    name: $name, color: $color,
                    superCategoryIndex: $superCategoryIndex,
                    sfSymbolName: $sfSymbolName,
                    focusedField: _focusedField
                )
                if superCategoryIndex == -1 {
                    NewCategorySubcategoriesSection(
                        allSymbols: allSymbols,
                        children: $children,
                        focusedField: _focusedField
                    )
                }
            }
            .navigationTitle("Новая категория")
#if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
#else
            .padding()
#endif
            
            Button(action: {
                if superCategoryIndex == -1 {
                    CategoriesService.shared.addCategory(
                        ExpensesCategory(
                            id: UUID().uuidString,
                            name: name,
                            type: .superCategory(ExpensesCategory.SFSymbol(name: sfSymbolName, color: color)),
                            order: allCategories.count,
                            children: children
                        )
                    )
                } else {
                    let superCategoryToChange = allCategories[superCategoryIndex]
                    let subCategory = ExpensesCategory(
                        id: UUID().uuidString,
                        name: name,
                        type: .subCategory,
                        order: superCategoryToChange.children.count
                    )
                    CategoriesService.shared.addSubCategory(subCategory, to: superCategoryToChange)
                }
                isPresented = false
            }, label: {
                Text("Сохранить")
            })
            .padding(.bottom, 8)
            .disabled(name.isEmpty || (children.filter({ !$0.name.isEmpty }).isEmpty && superCategoryIndex == -1))
        }
        .onAppear {
//            focusedField = .categoryName
        }
        .frame(
            minHeight: 300 + CGFloat(children.count * 24),
            idealHeight: 300 + CGFloat(children.count * 24)
        )
    }
}

#Preview {
    NewCategoryView(isPresented: .constant(true))
}
