//
//  ModifyDirectionView.swift
//  Recipetory
//
//  Created by Ryo Martin on 22/11/23.
//

import SwiftUI

struct ModifyDirectionView: ModifyComponentView {
    @Binding var direction: Direction
    let createAction: (Direction) -> Void
    
    init(component: Binding<Direction>, createAction: @escaping (Direction) -> Void) {
        self._direction = component
        self.createAction = createAction
    }
    
   @AppStorage("listBgColor") private var listBgColor = AppColor.background
    private let listTxtColor = AppColor.foreground
    
    @Environment(\.presentationMode) private var mode
    
    var body: some View {
        Form {
            TextField("Direction Description", text: $direction.description).listRowBackground(listBgColor)
            Toggle("Optional", isOn: $direction.isOptional)
                .listRowBackground(listBgColor)
            HStack {
                Spacer()
                Button("Save") {
                    createAction(direction)
                    mode.wrappedValue.dismiss()
                }
                Spacer()
            }.listRowBackground(listBgColor)
        }.foregroundColor(listTxtColor)
    }
}

struct ModifyDirectionView_Previews: PreviewProvider {
    @State static var emptyDirection = Direction(description: "", isOptional: false)
    static var previews: some View {
        NavigationView {
            ModifyDirectionView(component: $emptyDirection) {
                _ in return
            }
        }
    }
}
