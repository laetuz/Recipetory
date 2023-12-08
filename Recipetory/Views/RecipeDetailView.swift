//
//  RecipeDetailView.swift
//  Recipetory
//
//  Created by Ryo Martin on 15/10/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: Recipe
    
    private let listBgColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            List {
                Section(header: Text("Ingredients")){
                    ForEach(recipe.ingredients.indices, id: \.self) {
                        index in let ingredients = recipe.ingredients[index]
                        Text(ingredients.description)
                    }
                    .foregroundColor(listTextColor)
                }
                .listRowBackground(listBgColor)
                Section(header: Text("Directions")){
                    ForEach(recipe.directions.indices, id: \.self) {
                        index in let ingredients = recipe.directions[index]
                        HStack {
                            let direction = recipe.directions[index]
                            Text("\(index + 1). ").bold()
                            Text("\(direction.isOptional ? "(Optional " : "") \(ingredients.description)")
                        }
                        .foregroundColor(listTextColor)
                    }
                    .listRowBackground(listBgColor)
                }
            }
        }.navigationTitle(recipe.mainInformation.name)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[0]
    static var previews: some View {
        NavigationView {
            RecipeDetailView(recipe: $recipe)
        }
    }
}
