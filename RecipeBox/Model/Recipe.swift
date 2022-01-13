//
//  recipe.swift
//  RecipeBox
//
//  Created by James Martin on 12/31/21.
//

import Foundation
import SwiftUI

struct Recipe: Identifiable {
    var id: String
    var name: String
    var notes: String
    var isFavorite: Bool
    var difficulty: String
    var dateMade: Date
    var cookTime: String
    var isVegan: Bool
    var url: String
    //var imageName: String
    var image: Data
    
    
    
    init(RecipeObject: RecipeObject) {
        self.id = RecipeObject.id.stringValue
        self.name = RecipeObject.name
        self.notes = RecipeObject.notes
        self.isFavorite = RecipeObject.isFavorite
        self.difficulty = RecipeObject.difficulty
        self.dateMade = RecipeObject.dateMade
        self.cookTime = RecipeObject.cookTime
        self.isVegan = RecipeObject.isVegan
        self.url = RecipeObject.url
        //self.imageName = RecipeObject.imageName
        self.image = RecipeObject.image
    }
}
