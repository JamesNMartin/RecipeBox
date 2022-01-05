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
    // 2022-01-01 23:38:28 +0000
    var dateMade: String
    var cookTime: String
    var isVegan: Bool
    var url: String
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
