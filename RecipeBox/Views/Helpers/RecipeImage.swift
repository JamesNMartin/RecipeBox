//
//  RecipeImage.swift
//  RecipeBox
//
//  Created by James Martin on 1/9/22.
//

import SwiftUI
//import NukeUI
//import Nuke
import RealmSwift

struct RecipeImage: View {
	var image: Image
	
	var body: some View {
			image
				.resizable()
				.ignoresSafeArea(edges: .top)
				.aspectRatio(contentMode: .fill)
				.frame(width: UIScreen.main.bounds.width - 24, height: UIScreen.main.bounds.width - 24, alignment: .center)
				.clipped()
				//.allowsHitTesting(false)
				.overlay(ImageOverlay(), alignment: .bottomLeading)
				.layoutPriority(-1)
	}
}

struct ImageOverlay: View {
	var body: some View {
		ZStack {
			Rectangle()                         // Shapes are resizable by default
				.foregroundColor(.clear)        // Making rectangle transparent
				.background(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .center, endPoint: .bottom))
		}
	}
}
//
//struct RecipeImage_Previews: PreviewProvider {
//	static var previews: some View {
//		RecipeImage(image: Image("soup"), title: "Title", cookTime: "Cook time", cuisine: "cuisine", difficulty: "difficulty", dateMade: "January 20, 2022")
//	}
//}
