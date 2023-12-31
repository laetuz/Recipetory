//
//  Recipe.swift
//  Recipetory
//
//  Created by Ryo Martin on 13/10/23.
//

import Foundation

struct Recipe: Identifiable {
    var id = UUID()
    var mainInformation: MainInformation
    var ingredients: [Ingredient]
    var directions: [Direction]
    
    var isValid: Bool {
        mainInformation.isValid && !ingredients.isEmpty && !directions.isEmpty
    }
    
    init(mainInformation: MainInformation, ingredients: [Ingredient], directions: [Direction]) {
        self.mainInformation = mainInformation
        self.ingredients = ingredients
        self.directions = directions
    }
    
    init() {
        self.init(
            mainInformation:
                MainInformation(
                    name: "",
                    description: "",
                    author: "",
                    category: .breakfast),
            ingredients: [],
            directions: []
        )
    }
}
