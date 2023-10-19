//
//  RecipesListView.swift
//  Recipetory
//
//  Created by Ryo Martin on 15/10/23.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject private var recipeData: RecipeData
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
    let category: MainInformation.Category
    private let listBgColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        List {
            ForEach(recipes) {
                recipe in
                NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: recipe))
            }
            .listRowBackground(listBgColor)
            .foregroundColor(listTextColor)
        }
        .navigationTitle(navigationTitle)
        .toolbar(
            content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(
                        action: {
                            isPresenting = true
                        }, label: {
                            Image(systemName: "plus")
                        }
                )
            }}
        ).sheet(isPresented: $isPresenting) {
            NavigationView {
                ModifyRecipeView(recipe: $newRecipe).toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresenting = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        if newRecipe.isValid {
                            Button("Add") {
                                recipeData.addRecipe(recipe: newRecipe)
                                isPresenting = false
                            }
                        }
                    }
                }.navigationTitle("Add a New Recipe")
            }
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
