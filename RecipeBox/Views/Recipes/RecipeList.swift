//
//  RecipeList.swift
//  RecipeBox
//
//  Created by James Martin on 12/31/21.
//

import SwiftUI
import RealmSwift

// HEX to UIColor: https://www.uicolor.io

struct RecipeList: View {
	@EnvironmentObject var modelData: RecipeViewModel
	@State private var showFavoritesOnly = false
	@State private var showingSheet = false
	@State private var filterBy  = ""
	@State private var queryString: String = ""
	
//	var filteredRecipes: [Recipe] {
//		modelData.recipes.filter { recipe in
//			(!showFavoritesOnly || recipe.isFavorite)
//		}
//	}
	
	var body: some View {
		NavigationView {
			List {
				//                Toggle(isOn: $showFavoritesOnly) {
				//                    Text("Favorites Only")
				//                }
				//                //.listStyle(.plain)
				//                .tint(Color.accentColor)
				//
//				ForEach(filteredRecipes) { recipe in
//					NavigationLink {
//						RecipeDetail(recipe: recipe)
//					} label: {
//						RecipeRow(recipe: recipe)
//						//.listRowSeparatorTint(Color.init(UIColor(red: 0.79, green: 0.77, blue: 0.81, alpha: 1.00)))
//
//					}
//				}
				ForEach(modelData.recipes, id: \.id) { recipe in
					NavigationLink(destination: RecipeDetail(recipe: recipe)) {
						RecipeRow(recipe: recipe)
					}
					
				}
				//.onDelete(perform: )
			}
			.navigationTitle("Recipe List")
			.listStyle(.plain)
			.toolbar {
				ToolbarItemGroup(placement: .bottomBar) {
					Button("\(Image(systemName: "plus.circle.fill")) Add Recipe") {
						showingSheet.toggle()
					}
					.font(.system(.body, design: .rounded).bold())
					Spacer()
				}
				ToolbarItemGroup(placement: .navigationBarLeading) {
					Button("\(Image(systemName: "gearshape"))") {
						// DO SOMETHING
					}
				}
				ToolbarItemGroup(placement: .navigationBarTrailing) {
					EditButton()
				}
			}
		}
		
		.searchable(text: $queryString)
		.sheet(isPresented: $showingSheet) {
			AddRecipe()
		}
	}
}
struct RecipeList_Previews: PreviewProvider {
	static var previews: some View {
		ForEach(["iPhone 12 Pro Max"], id: \.self) { deviceName in
			RecipeList()
				.environmentObject(RecipeObject())
				.previewDevice(PreviewDevice(rawValue: deviceName))
				.previewDisplayName(deviceName)
		}
	}
}
//struct RecipeList_Previews: PreviewProvider {
//    static var previews: some View {
//        RecipeList()
//            .environmentObject(ModelData())
//    }
//}
