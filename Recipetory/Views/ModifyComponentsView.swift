//
//  ModifyIngredientsView.swift
//  Recipetory
//
//  Created by Ryo Martin on 12/11/23.
//

import SwiftUI

protocol RecipeComponent: CustomStringConvertible {
    init()
    static func singularName() -> String
    static func pluralName() -> String
}

extension RecipeComponent {
    static func singularName() -> String {
        String(describing: self).lowercased()
    }
    static func pluralName() -> String {
        self.singularName() + "s"
    }
}

protocol ModifyComponentView: View {
    associatedtype Component
    init(component: Binding<Component>, createAction: @escaping (Component) -> Void)
}

struct ModifyComponentsView<Component: RecipeComponent, DestinationView: ModifyComponentView>: View where DestinationView.Component == Component {
    @Binding var components: [Component]
    @State private var newComponent = Component()

    var body: some View {
        
        VStack {
            let addComponentView = DestinationView(component: $newComponent) {
                component in
                components.append(component)
                newComponent = Component()
            }.navigationTitle("Add \(Component.singularName().capitalized)")
            if components.isEmpty {
                Spacer()
                NavigationLink("Add the first \(Component.singularName())", destination: addComponentView)
                Spacer()
            } else {
                HStack {
                    Text(Component.pluralName().capitalized)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .padding()
                    Spacer()
                    EditButton()
                        .padding()
                }
                List {
                    ForEach(components.indices, id: \.self) { index in
                        let component = components[index]
                        let editComponent = DestinationView(component: $components[index]) { _ in
                            return
                        }
                            .navigationTitle("Edit \(Component.singularName().capitalized)")
                        NavigationLink(component.description, destination: editComponent)
                       // Text(component.description)
                    }
                    .onDelete( perform: { components.remove(atOffsets: $0)})
                    .onMove(perform: { indices, newOffset in
                        components.move(fromOffsets: indices, toOffset: newOffset)
                    })
                    NavigationLink("Add another \(Component.singularName())", destination: addComponentView).buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct ModifyIngredientsView_Previews: PreviewProvider {
    @State static var emptyIngredients = [Ingredient]()
    @State static var recipe = [Recipe()]
    
  static var previews: some View {
      NavigationView {
          ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $emptyIngredients)
      }
//      NavigationView {
//          ModifyComponentsView<Ingredient, ModifyIngredientView>(ingredients: $recipe.ingredients)
//      }
  }
}
