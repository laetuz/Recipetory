//
//  Ingredient.swift
//  Recipetory
//
//  Created by Ryo Martin on 13/10/23.
//

import Foundation

struct Ingredient: RecipeComponent {
    var name: String
    var quantity: Double
    var unit: Unit
    
    var description: String {
        let formattedQuantity = String(format: "%g", quantity)
        switch unit {
        case .none:
            let formattedName = quantity == 1 ? name : "\(name)s"
            return "\(formattedQuantity) \(formattedName)"
        default:
            if quantity == 1 {
                return "1 \(unit.singularName) \(name)"
            } else {
                return "\(formattedQuantity) \(unit.rawValue) \(name))"
            }
        }
    }
    
    enum Unit: String, CaseIterable {
        case oz = "Ounces"
        case g = "Grams"
        case cups = "Cups"
        case tbs = "Tablespoons"
        case tsp = "Teaspoons"
        case none = "No units"
        
        var singularName: String {String(rawValue.dropLast())}
    }
    
    init(name: String, quantity: Double, unit: Unit) {
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }
    
    init() {
        self.init(name: "", quantity: 1.0, unit: .none)
    }
}
