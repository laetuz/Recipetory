//
//  Recipe.swift
//  Recipetory
//
//  Created by Ryo Martin on 13/10/23.
//

import Foundation

struct Recipe {
    var mainInformation: MainInformation
    var ingredients: [Ingredient]
    var directions: [Direction]
    
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
