//
//  RecipeCategoryGridView.swift
//  Recipetory
//
//  Created by Ryo Martin on 17/10/23.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    @StateObject private var recipeData = RecipeData()
    @State private var isPresenting = false
    let columns = [GridItem(), GridItem()]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(MainInformation.Category.allCases, id: \.self) {
                        category in
                        NavigationLink(
                            destination: RecipesListView(
                                category: category).environmentObject(recipeData),
                            label: {
                                CategoryView(category: category)
                            }
                        )
                    }
                })
            }.navigationTitle("Categories")
        }
    }
}

struct CategoryView: View {
    let category: MainInformation.Category
    var body: some View {
        ZStack {
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.35)
            Text(category.rawValue)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    RecipeCategoryGridView()
}
