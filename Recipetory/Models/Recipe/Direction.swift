//
//  Direction.swift
//  Recipetory
//
//  Created by Ryo Martin on 13/10/23.
//

import Foundation

struct Direction: RecipeComponent {
    var description: String
    var isOptional: Bool
    
    init(description: String, isOptional: Bool) {
        self.description = description
        self.isOptional = isOptional
    }
    
    init() {
        self.init(description: "", isOptional: false)
    }
}
