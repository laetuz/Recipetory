//
//  RecipeData.swift
//  Recipetory
//
//  Created by Ryo Martin on 15/10/23.
//

import Foundation

class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
}
