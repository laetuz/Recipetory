//
//  RecipeData.swift
//  Recipetory
//
//  Created by Ryo Martin on 15/10/23.
//

import Foundation

class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
    private var recipesFileUrl: URL {
        do {
            let documentsDirectory = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )
            return documentsDirectory.appendingPathComponent("recipeData")
        } catch {
            fatalError("An error while getting the url for \(error)")
        }
    }
    
    var favoriteRecipes: [Recipe] {
        recipes.filter { $0.isFavorite }
    }
    
    func recipes(for category: MainInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        for recipe in recipes {
            if recipe.mainInformation.category == category {
                filteredRecipes.append(recipe)
            }
        }
        return filteredRecipes
    }
    
    func addRecipe(recipe: Recipe) {
        if recipe.isValid {
            recipes.append(recipe)
            saveRecipes()
        }
    }
    
    func index(of recipe:Recipe) -> Int? {
        for i in recipes.indices {
            if recipes[i].id == recipe.id {
                return i
            }
        }
        return nil
    }
    
    func saveRecipes() {
        do {
            let encodedData = try JSONEncoder().encode(recipes)
            try encodedData.write(to: recipesFileUrl)
        } catch {
            fatalError("An error occured while saving recipes: \(error)")
        }
    }
    
    func loadRecipes() {
        guard let data = try? Data(contentsOf: recipesFileUrl) else {
            return
        }
        do {
            let savedRecipes = try JSONDecoder().decode([Recipe].self, from: data)
            recipes = savedRecipes
        } catch {
            fatalError("An error occured while saving recipes: \(error)")
        }
    }
}
