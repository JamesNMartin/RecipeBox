//
//  RecipeObject.swift
//  RecipeBox
//
//  Created by James Martin on 1/7/22.
//

import Foundation
import RealmSwift

class RecipeObject: Object {
    @Persisted (primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var notes: String
    @Persisted var isFavorite: Bool
    @Persisted var difficulty: String
    @Persisted var dateMade: Date
    @Persisted var cookTime: String
    @Persisted var isVegan: Bool
    @Persisted var url: String
    @Persisted var imageName: String
}
