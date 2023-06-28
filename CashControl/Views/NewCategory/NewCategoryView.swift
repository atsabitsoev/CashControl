//
//  NewCategoryView.swift
//  CashControl
//
//  Created by Ацамаз Бицоев on 28.06.2023.
//

import SwiftUI

struct NewCategoryView: View {
    enum FocusedField: Hashable {
        case categoryName
        case subCategoryName(categoryId: String)
    }
    
    
    private let allCategories: [ExpensesCategory] = ExpensesCategory.all
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
    @FocusState private var focusedField: FocusedField?
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Оформление") {
                    TextField(text: $name) {
                        Text("Название категории")
                    }
                    .focused($focusedField, equals: .categoryName)
                    if superCategoryIndex == -1 {
                        ColorPicker("Цвет", selection: $color)
                        Picker("Символ", selection: $sfSymbolName, content: {
                            ForEach(allSymbols, id: \.0) { symbol in
#if os(macOS)
                                HStack {
                                    Text(symbol.1)
                                    Image(systemName: symbol.0)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 24)
                                        .foregroundStyle(color)
                                }
                                .tag(symbol.0)
#else
                                Label {
                                    Text(symbol.1)
                                } icon: {
                                    Image(systemName: symbol.0)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 24)
                                        .foregroundStyle(color)
                                }
                                .tag(symbol.0)
#endif
                            }
                        })
#if !os(macOS)
                        .pickerStyle(NavigationLinkPickerStyle())
#endif
                    }
                }
                Section("Организация") {
                    Picker("Поместить в категорию", selection: $superCategoryIndex) {
                        ForEach(0..<allCategories.count, id: \.self) { index in
                            Label {
                                Text(allCategories[index].name).tag(index)
                                    .minimumScaleFactor(0.1)
                                    .lineLimit(2)
                            } icon: {
                                if let symbol = allCategories[index].symbol {
                                    Image(systemName: symbol.name)
                                        .foregroundStyle(symbol.color)
                                } else {
                                    EmptyView()
                                }
                            }
                            
                        }
                        Text("Нет").tag(-1)
                    }
#if !os(macOS)
                    .pickerStyle(NavigationLinkPickerStyle())
#endif
                }
                if superCategoryIndex == -1 {
                    Section("Подкатегории") {
                        ForEach(children, id: \.id) { child in
                            TextField("Название подкатегории", text: .init(get: {
                                children.first(where: { $0.id == child.id })?.name ?? "Hello"
                            }, set: { newValue in
                                if let index = children.firstIndex(where: { $0.id == child.id }) {
                                    children[index] = ExpensesCategory(id: child.id, name: newValue)
                                }
                            }))
                            .submitLabel(.done)
                            .onSubmit({
                                children.removeAll(where: { $0.name.isEmpty })
                            })
                            .focused($focusedField, equals: .subCategoryName(categoryId: child.id))
                            .onAppear {
                                focusedField = .subCategoryName(categoryId: child.id)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            children.remove(atOffsets: indexSet)
                        })
                        Button(action: {
                            children.append(ExpensesCategory(id: UUID().uuidString, name: ""))
                        },
                               label: {
                            Text("Добавить подкатегорию")
                        })
                        .disabled(children.contains(where: { $0.name.isEmpty }))
                    }
                }
            }
            .navigationTitle("Новая категория")
#if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
#else
            .padding()
#endif
            
            Button(action: {
                print("Hello")
            }, label: {
                Text("Сохранить")
            })
            .padding(.bottom, 8)
            .disabled(name.isEmpty || (children.filter({ !$0.name.isEmpty }).isEmpty && superCategoryIndex == -1))
        }
        .onAppear {
            focusedField = .categoryName
        }
        .frame(
            minHeight: 300 + CGFloat(children.count * 24),
            idealHeight: 300 + CGFloat(children.count * 24)
        )
    }
}

#Preview {
    NewCategoryView()
}
