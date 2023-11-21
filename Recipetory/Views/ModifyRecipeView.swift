//
//  ModifyRecipeView.swift
//  Recipetory
//
//  Created by Ryo Martin on 19/10/23.
//

import SwiftUI

struct ModifyRecipeView: View {
    @Binding var recipe: Recipe
    @State private var selection = Selection.main
    
    var body: some View {
        VStack {
            Picker("Select recipe components", selection: $selection){
                Text("Main Info").tag(Selection.main)
                Text("Ingredients").tag(Selection.ingredients)
                Text("Directions").tag(Selection.directions)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            switch selection {
            case .main:
                ModifyMainInformationView(mainInfo: $recipe.mainInformation)
            case .ingredients:
                ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)
            case .directions:
                ModifyComponentsView<Direction, ModifyDirectionView>(components: $recipe.directions)
            }
            Spacer()
        }
        Button("Fill in the recipe with test data.") {
            recipe.mainInformation = MainInformation(
                name: "test",
                description: "test",
                author: "test",
                category: .breakfast)
            recipe.directions = [
                Direction(description: "test", isOptional: false)
            ]
            recipe.ingredients = [
                Ingredient(
                    name: "test",
                    quantity: 1.0,
                    unit: .none)
            ]
        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    enum Selection {
        case main
        case ingredients
        case directions
    }
}

struct ModifyRecipeView_Previews: PreviewProvider {
    @State static var recipe = Recipe()
    static var previews: some View {
        ModifyRecipeView(recipe: $recipe)
    }
}
