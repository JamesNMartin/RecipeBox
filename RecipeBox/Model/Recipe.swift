//
//  recipe.swift
//  RecipeBox
//
//  Created by James Martin on 12/31/21.
//

import Foundation
import SwiftUI

struct Recipe: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var description: String
    var isFavorite: Bool
    var difficulty: String
    var dateMade: String
    var cookTime: String
    var isVegan: Bool
    var url: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
