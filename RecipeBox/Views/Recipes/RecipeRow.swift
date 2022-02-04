//
//  RecipeRow.swift
//  RecipeBox
//
//  Created by James Martin on 12/31/21.
//

import SwiftUI

struct RecipeRow: View {
	var recipe: Recipe
	
	var body: some View {
		HStack {
			Image(uiImage: UIImage(data: recipe.image as Data)!)
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 60, height: 60)
			//.clipShape(Circle())
				.cornerRadius(10)
				.clipped()
			VStack(alignment: .leading ,spacing: 0) {
				Text(recipe.name)
					.font(.system(.body)).bold()
				Text(recipe.cookTime)
					.font(.subheadline)
					.foregroundColor(.secondary)
				Text("Made \(numberOfDaysBetween(startDate: recipe.dateMade, endDate: Date.now)) days ago")
					.font(.subheadline)
					.foregroundColor(.secondary)
					.padding(.bottom, 2.0)
				HStack {
					if recipe.isVegan {
						Text("Vegan \(Image(systemName: "leaf.fill"))")
							.modifier(VegLabelStyle())
							.font(.system(size: 12))
					}
					if recipe.isVegetarian {
						Text("Vegetarian \(Image(systemName: "leaf"))")
							.modifier(VegLabelStyle())
							.font(.system(size: 12))
					}
					Text("\(recipe.cuisine) \(Image(systemName: "globe.americas"))")
						.modifier(CuisineLabelStyle())
						.font(.system(size: 12))
				}
			}
			Spacer()
			if recipe.isFavorite {
				Image(systemName: "heart.fill")
					.foregroundColor(.red)
			}
		}
	}
	func numberOfDaysBetween(startDate: Date, endDate: Date) -> Int {
		let calendar = Calendar.current
		let components = calendar.dateComponents([.day], from: startDate, to: endDate)
		return components.day!
	}
}

struct VegLabelStyle: ViewModifier {
	
	func body(content: Content) -> some View {
		content
			.font(.caption)
			.foregroundColor(Color(.systemBackground))
			.padding(.horizontal, 5.0)
			.padding(.vertical, 2.0)
			//.background(Color.init(UIColor(named: "Michaelas-Color-1")!))
			.background(.gray)
			.clipShape(Capsule())
	}
}
struct CuisineLabelStyle: ViewModifier {
	
	func body(content: Content) -> some View {
		content
			.font(.caption)
			.foregroundColor(Color(.systemBackground))
			.padding(.horizontal, 5.0)
			.padding(.vertical, 2.0)
			//.background(Color.init(UIColor(named: "Michaelas-Color-2")!))
			.background(.gray)
			.clipShape(Capsule())
	}
}

struct LandmarkRow_Previews: PreviewProvider {
	static var recipes = RecipeViewModel().recipes
	
	static var previews: some View {
		Group {
			RecipeRow(recipe: recipes[0])
			//RecipeRow(recipe: recipes[3])
		}
		.previewLayout(.fixed(width: 400, height: 70))
	}
}
