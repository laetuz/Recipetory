//
//  Recipe.swift
//  Recipetory
//
//  Created by Ryo Martin on 13/10/23.
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id = UUID()
    var mainInformation: MainInformation
    var ingredients: [Ingredient]
    var directions: [Direction]
    var isFavorite = false
    
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
    
    func index(of direction: Direction, excludingOptionalDirections: Bool) -> Int? {
        let directions = directions.filter { excludingOptionalDirections ? !$0.isOptional : true }
           let index = directions.firstIndex { $0.description == direction.description }
           return index
    }
}
