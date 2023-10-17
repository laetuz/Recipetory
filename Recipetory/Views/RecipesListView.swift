//
//  RecipesListView.swift
//  Recipetory
//
//  Created by Ryo Martin on 15/10/23.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject private var recipeData: RecipeData
    let category: MainInformation.Category
    private let listBgColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        NavigationView {
            List {
                ForEach(recipes) {
                    recipe in 
                    NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: recipe))
                }
                .listRowBackground(listBgColor)
                .foregroundColor(listTextColor)
            }.navigationTitle(navigationTitle)
        }
    }
}

extension RecipesListView {
     private var recipes: [Recipe] {
        recipeData.recipes(for: category)
    }
    var navigationTitle: String {
        "\(category.rawValue) Recipes"
    }
}

struct RecipeListViewPreviews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipesListView(category: .breakfast)
                .environmentObject(RecipeData())
        }
    }
}
