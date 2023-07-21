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
        ("house", "Жилье"),
        ("car", "Автомобиль"),
        ("fork.knife", "Еда"),
        ("cup.and.saucer", "Кофе"),
        ("tshirt", "Одежда"),
        ("shoe", "Обувь"),
        ("bag", "Сумка"),
        ("dollarsign", "Деньги"),
        ("heart", "Здоровье"),
        ("globe", "Путешествия"),
        ("book", "Образование"),
        ("music.note", "Музыка"),
        ("camera", "Фотография"),
        ("film", "Кино"),
        ("gamecontroller", "Игры"),
        ("bicycle", "Фитнес"),
        ("pencil", "Творчество"),
        ("leaf", "Экология"),
        ("bed.double", "Отдых"),
        ("gift", "Подарки"),
        ("hourglass", "Время"),
        ("paintbrush", "Искусство"),
        ("cloud", "Облако"),
        ("sun.max", "Солнце"),
        ("moon.stars", "Луна и звезды"),
        ("creditcard", "Кредитная карта"),
        ("train.side.front.car", "Поезд"),
        ("airplane", "Самолет"),
        ("bus", "Автобус"),
        ("lightbulb", "Лампочка"),
        ("graduationcap", "Шапочка выпускника"),
        ("mic", "Микрофон"),
        ("guitars", "Гитары"),
        ("gauge", "Измерение"),
        ("flame", "Огонь"),
        ("dumbbell", "Спорт"),
        ("camera.aperture", "Диафрагма"),
        ("headphones", "Наушники"),
        ("film", "Пленка"),
        ("airpods", "Беспроводные наушники"),
        ("homekit", "Умный дом"),
        ("desktopcomputer", "Компьютер"),
        ("laptopcomputer", "Ноутбук"),
        ("ipad.gen2.landscape", "Планшет"),
        ("keyboard", "Клавиатура"),
        ("printer", "Принтер"),
        ("scissors", "Ножницы"),
        ("pawprint", "Лапа"),
        ("shippingbox", "Коробка")
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
