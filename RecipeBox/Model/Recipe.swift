//
//  recipe.swift
//  RecipeBox
//
//  Created by James Martin on 12/31/21.
//

import Foundation
import SwiftUI
import Realm

class Recipe: Identifiable, ObservableObject, Codable {
    var id: String
    var name: String
    var notes: String
	var ingredients: String
    var isFavorite: Bool
    var difficulty: String
	var servingSize: Int
    var dateMade: Date
    var cookTime: String
    var isVegan: Bool
	var isVegetarian: Bool
	var cuisine: String
	var numberOfTimesMade: Int
    var url: String
    var image: Data

    init(RecipeObject: RecipeObject) {
        self.id = RecipeObject.id.stringValue
        self.name = RecipeObject.name
        self.notes = RecipeObject.notes
		self.ingredients = RecipeObject.ingredients
        self.isFavorite = RecipeObject.isFavorite
        self.difficulty = RecipeObject.difficulty
		self.servingSize = RecipeObject.servingSize
        self.dateMade = RecipeObject.dateMade
        self.cookTime = RecipeObject.cookTime
        self.isVegan = RecipeObject.isVegan
		self.isVegetarian = RecipeObject.isVegetarian
		self.cuisine = RecipeObject.cuisine
		self.numberOfTimesMade = RecipeObject.numberOfTimesMade
        self.url = RecipeObject.url
        self.image = RecipeObject.image
    }
}
