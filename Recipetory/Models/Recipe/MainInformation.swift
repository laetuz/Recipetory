//
//  MainInformation.swift
//  Recipetory
//
//  Created by Ryo Martin on 13/10/23.
//

import Foundation

struct MainInformation: Codable {
    var name: String
    var description: String
    var author: String
    var category: Category
    
    var isValid: Bool {
        !name.isEmpty && !description.isEmpty && !author.isEmpty
    }
    
    enum Category: String, CaseIterable, Codable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner"
        case dessert = "Dessert"
    }
}
