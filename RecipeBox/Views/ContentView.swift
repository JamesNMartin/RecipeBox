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
	init() {
		var titleFont = UIFont.preferredFont(forTextStyle: .largeTitle) /// the default large title font
		titleFont = UIFont(
			descriptor:
				titleFont.fontDescriptor
				.withDesign(.rounded)? /// make rounded
				.withSymbolicTraits(.traitBold) /// make bold
			??
			titleFont.fontDescriptor, /// return the normal title if customization failed
			size: titleFont.pointSize
		)
		UINavigationBar.appearance().largeTitleTextAttributes = [.font: titleFont]
	}
	var body: some View {
		RecipeList()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environmentObject(RecipeViewModel())
	}
}
