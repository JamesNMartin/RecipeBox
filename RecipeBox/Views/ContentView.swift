//
//  ContentView.swift
//  RecipeBox
//
//  Created by James Martin on 12/31/21.
//
// IF PREVIEW CRASHES XCODE RUN 'xcrun simctl --set previews delete all'
// IN TERMINAL

import SwiftUI

struct ContentView: View {
    var body: some View {
        RecipeList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
