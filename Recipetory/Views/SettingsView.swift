//
//  SettingsView.swift
//  Recipetory
//
//  Created by Ryo Martin on 25/01/24.
//

import SwiftUI

struct SettingsView: View {
    @State private var hideOptionalSteps: Bool = false
    @State private var listBgColor = AppColor.background
    @State private var listTextColor = AppColor.foreground
    
    var body: some View {
        NavigationView {
            Form {
                ColorPicker("Background Color", selection: $listBgColor)
                    .padding()
                    .listRowBackground(listBgColor)
                ColorPicker("Text Color", selection: $listTextColor)
                    .padding()
                    .listRowBackground(listBgColor)
                Toggle("Hide Optional Steps", isOn: $hideOptionalSteps)
                    .padding()
                    .listRowBackground(listBgColor)
            }
            .foregroundColor(listTextColor)
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
