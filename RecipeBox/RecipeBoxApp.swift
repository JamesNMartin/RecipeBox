//
//  RecipeBoxApp.swift
//  RecipeBox
//
//  Created by James Martin on 12/31/21.
//

import SwiftUI

@main
struct RecipeBoxApp: App {
    @StateObject private var modelData = RecipeViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
