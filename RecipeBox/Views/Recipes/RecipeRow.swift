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
                .frame(width: 50, height: 50)
                //.clipShape(Circle())
                .cornerRadius(10)
				.clipped()
            VStack(alignment: .leading ,spacing: 0) {
                Text(recipe.name)
                Text(recipe.cookTime)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
				HStack {
					if recipe.isVegan {
						Text("Vegan \(Image(systemName: "leaf.fill"))")
							.modifier(VegLabelStyle())
							.font(.system(size: 12))
							.foregroundColor(.green)
					}
					if recipe.isVegetarian {
						Text("Vegetarian \(Image(systemName: "leaf"))")
							.modifier(VegLabelStyle())
							.font(.system(size: 12))
							.foregroundColor(.green)
					}
					Text("\(recipe.cuisine) \(Image(systemName: "globe.americas"))")
						.modifier(CuisineLabelStyle())
						.font(.system(size: 12))
						.foregroundColor(.red)
				}
            }
            Spacer()
            if recipe.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct VegLabelStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundColor(Color(.systemBackground))
            .padding(.horizontal, 5.0)
            .padding(.vertical, 2.0)
            .background(.green)
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
			.background(.yellow)
			//.background(Color.init(UIColor(red: 0.55, green: 0.53, blue: 0.79, alpha: 1.00)))
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
