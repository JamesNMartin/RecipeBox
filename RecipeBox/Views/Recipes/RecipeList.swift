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
	
	var filteredRecipes: [Recipe] {
		modelData.recipes.filter { recipe in
			(!showFavoritesOnly || recipe.isFavorite)
		}
	}
	var body: some View {
		NavigationView {
			List {
				//                Toggle(isOn: $showFavoritesOnly) {
				//                    Text("Favorites Only")
				//                }
				//                //.listStyle(.plain)
				//                .tint(Color.accentColor)
				//
				ForEach(filteredRecipes) { recipe in
					NavigationLink {
						RecipeDetail(recipe: recipe)
					} label: {
						RecipeRow(recipe: recipe)
						//.listRowSeparatorTint(Color.init(UIColor(red: 0.79, green: 0.77, blue: 0.81, alpha: 1.00)))
						
					}
				}
			}
			.navigationTitle("Dinner List")
			.listStyle(.plain)
			.navigationBarItems(trailing: Button(action: {
				//showingSheet.toggle()
				showingSheet = true
			}) {
				Image(systemName: "plus").imageScale(.large)
			})
			.navigationBarItems(leading: Button(action: {
//				let realm = try! Realm()
//				try! realm.write {
//					realm.deleteAll()
//				}
				//showingSheet.toggle()
			}) {
				Image(systemName: "gearshape").imageScale(.large)
			})
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
