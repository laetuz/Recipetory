//
//  ModifyIngredientsView.swift
//  Recipetory
//
//  Created by Ryo Martin on 12/11/23.
//

import SwiftUI

struct ModifyIngredientView: ModifyComponentView {
    @Binding var ingredient: Ingredient
    let createAction: ((Ingredient) -> Void)
    @Environment(\.presentationMode) private var mode
    
    init(component: Binding<Ingredient>, createAction: @escaping (Ingredient) -> Void) {
        self._ingredient = component
        self.createAction = createAction
    }
    
    private let listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            Form {
                TextField("Ingredient", text: $ingredient.name).listRowBackground(listBackgroundColor)
                Stepper(value: $ingredient.quantity, in: 1...100, step: 0.5) {
                    HStack {
                        Text("Quantity:")
                        let decFormat: NumberFormatter = {
                            let formatter = NumberFormatter()
                            formatter.numberStyle = .decimal
                            return formatter
                        }()
                        TextField("Quantity",
                                  value: $ingredient.quantity,
                                  formatter: decFormat).keyboardType(.numbersAndPunctuation).textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }.listRowBackground(listBackgroundColor)
                Picker(
                    selection: $ingredient.unit,
                    label: HStack {
                        Text(ingredient.unit.rawValue)
                    }) {
                        ForEach(Ingredient.Unit.allCases, id: \.self) {
                            unit in Text(unit.rawValue)
                        }
                    }
                    .listRowBackground(listBackgroundColor)
                    .pickerStyle(MenuPickerStyle())
                HStack {
                    Spacer()
                    Button("Save") {
                        createAction(ingredient)
                        mode.wrappedValue.dismiss()
                    }
                    Spacer()
                }.listRowBackground(listBackgroundColor)
            }.foregroundColor(listTextColor)
        }
    }
}

struct ModifyIngredientView_Previews: PreviewProvider {
  @State static var emptyIngredient = Ingredient()
  static var previews: some View {
    NavigationView {
        ModifyIngredientView(component: $emptyIngredient) {
            ingredient in print (ingredient)
        }
    }
  }
}
