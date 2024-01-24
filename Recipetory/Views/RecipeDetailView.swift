//
//  RecipeDetailView.swift
//  Recipetory
//
//  Created by Ryo Martin on 15/10/23.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: Recipe
    // MutableStateOf isPresenting in Boolean value. Initial value is false
    @State private var isPresenting = false
    
   @AppStorage("listBgColor") private var listBgColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            }
            List {
                Section(header: Text("Ingredients")){
                    ForEach(recipe.ingredients.indices, id: \.self) {
                        index in let ingredients = recipe.ingredients[index]
                        Text(ingredients.description)
                    }
                    .foregroundColor(listTextColor)
                }
                .listRowBackground(listBgColor)
                Section(header: Text("Directions")){
                    ForEach(recipe.directions.indices, id: \.self) {
                        index in let ingredients = recipe.directions[index]
                        HStack {
                            let direction = recipe.directions[index]
                            Text("\(index + 1). ").bold()
                            Text("\(direction.isOptional ? "(Optional " : "") \(ingredients.description)")
                        }
                        .foregroundColor(listTextColor)
                    }
                    .listRowBackground(listBgColor)
                }
            }
        }.navigationTitle(recipe.mainInformation.name)
        // 2. Set the value for mutableStateOf isPresenting: Boolean to True
            .toolbar {
                ToolbarItem {
                    HStack {
                        Button("Edit") {
                            isPresenting = true
                        }
                        //creating favorite button with the boolean state
                        Button(action: {
                            recipe.isFavorite.toggle()
                        }) {
                            Image(systemName: recipe.isFavorite ? "heart.fill": "heart")
                        }
                    }
                }
                // 4. Back button bugfix from xcode 12.1
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("")
                }
            }
        // 3. show sheet using the value of isPresenting
            .sheet(isPresented: $isPresenting){
                NavigationView {
                    ModifyRecipeView(recipe: $recipe)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                HStack {
                                    Button("Save") {
                                        isPresenting = false
                                    }
                                }
                            }
                        }.navigationTitle("Edit Recipe")
                }
            }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[0]
    static var previews: some View {
        NavigationView {
            RecipeDetailView(recipe: $recipe)
        }
    }
}
