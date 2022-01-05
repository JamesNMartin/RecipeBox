//
//  RecipeList.swift
//  RecipeBox
//
//  Created by James Martin on 12/31/21.
//

import SwiftUI

struct RecipeList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    @State private var showingSheet = false
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
                    }
                }
            }
            .navigationTitle("Mealbox")
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                    })
                }
                
                ToolbarItemGroup(placement: .status) {
                    VStack(alignment: .center ,spacing: 0) {
                        Text("Filtered by:")
                            .font(.system(size: 11))
                        Button(action: {
                            
                        }, label: {
                            Text("None")
                                .font(.system(size: 11))
                        })
                    }
                }
                ToolbarItemGroup(placement: .bottomBar) {
                    Button(action: {
                        showingSheet = true
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            }
            //.listStyle(.plain)
            .navigationBarItems(trailing: Button(action: {
                //showingSheet.toggle()
                showingSheet = true
            }) {
                //Image(systemName: "plus").imageScale(.large)
            })
            .navigationBarItems(leading: Button(action: {
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
        ForEach(["iPhone SE (2nd generation)", "iPhone 12 Pro Max"], id: \.self) { deviceName in
            RecipeList()
                .environmentObject(ModelData())
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
