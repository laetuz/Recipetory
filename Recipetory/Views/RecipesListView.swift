//
//  RecipesListView.swift
//  Recipetory
//
//  Created by Ryo Martin on 15/10/23.
//

import SwiftUI

struct RecipesListView: View {
    @StateObject var recipeData = RecipeData()
    private let listBgColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        NavigationView {
            List {
                ForEach(recipes) {
                    recipe in Text(recipe.mainInformation.name)
                }
                .listRowBackground(listBgColor)
                .foregroundColor(listTextColor)
            }.navigationTitle(navigationTitle)
        }
    }
}

extension RecipesListView {
    var recipes: [Recipe] {
        recipeData.recipes
    }
    var navigationTitle: String {
        "All Recipes"
    }
}

#Preview {
    RecipesListView()
}
