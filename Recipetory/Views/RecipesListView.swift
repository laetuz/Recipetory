//
//  RecipesListView.swift
//  Recipetory
//
//  Created by Ryo Martin on 15/10/23.
//

import SwiftUI

struct RecipesListView: View {
    @EnvironmentObject private var recipeData: RecipeData
    let viewStyle: ViewStyle
    
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    
    private let listBgColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        List {
            ForEach(recipes) {
                recipe in
                NavigationLink(recipe.mainInformation.name, destination: RecipeDetailView(recipe: binding(for: recipe)))
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
         switch viewStyle {
         case let .singleCategory(Category): return recipeData.recipes(for: Category)
         case.favorites: return recipeData.favoriteRecipes
         }
    }
    private var navigationTitle: String {
        switch viewStyle {
        case let .singleCategory(Category): return "\(Category.rawValue)"
        case.favorites: return "Favorite Recipes"
        }
    }
    
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        guard let index = recipeData.index(of: recipe) else  {
            fatalError("Recipe not found")
        }
        return $recipeData.recipes[index]
    }
    //Creating enum for tab bar options
    enum ViewStyle {
        case favorites
        case singleCategory(MainInformation.Category)
    }
}

struct RecipeListViewPreviews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RecipesListView(viewStyle: .singleCategory(.breakfast))
                .environmentObject(RecipeData())
        }
    }
}
