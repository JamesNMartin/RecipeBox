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
            recipe.image
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            VStack(alignment: .leading ,spacing: 0) {
                Text(recipe.name)
                Text(recipe.cookTime)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                if recipe.isVegan {
                    Text("Vegan \(Image(systemName: "leaf.fill"))")
                        .modifier(LabelStyle())
                        .font(.system(size: 12))
                        .foregroundColor(.green)
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

struct LabelStyle: ViewModifier {
    
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

struct LandmarkRow_Previews: PreviewProvider {
    static var recipes = ModelData().recipes
    
    static var previews: some View {
        Group {
            RecipeRow(recipe: recipes[0])
            
            RecipeRow(recipe: recipes[3])
        }
        .previewLayout(.fixed(width: 400, height: 70))
    }
}
