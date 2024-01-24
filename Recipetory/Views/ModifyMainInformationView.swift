//
//  ModifyMainInformationView.swift
//  Recipetory
//
//  Created by Ryo Martin on 12/11/23.
//

import SwiftUI

struct ModifyMainInformationView: View {
   @AppStorage("listBgColor") private var listBgColor = AppColor.background
    private let listFgColor = AppColor.foreground
    @Binding var mainInfo: MainInformation
    
    var body: some View {
        Form {
            TextField("Recipe Name", text: $mainInfo.name).listRowBackground(listBgColor)
            TextField("Author", text: $mainInfo.author).listRowBackground(listBgColor)
            Section(header: Text("Description")) {
                TextEditor(text: $mainInfo.description).listRowBackground(listBgColor)
            }
            Picker(
                selection: $mainInfo.category,
                label: HStack {
                    Text("Category")
                    Spacer()
                    Text(mainInfo.category.rawValue)
                }
            ) {
                ForEach(MainInformation.Category.allCases, id: \.self) {
                    category in Text(category.rawValue)
                }
            }
            .listRowBackground(listBgColor)
            .pickerStyle(MenuPickerStyle())
        }.foregroundColor(listFgColor)
    }
}

struct ModifyMainInformationView_Previews: PreviewProvider {
    static var previews: some View {
        let mainInfo = Binding.constant(MainInformation(name: "martin", description: "Is a fighter", author: "Poe", category: MainInformation.Category.dessert))
        return ModifyMainInformationView(mainInfo: mainInfo)
    }
}
