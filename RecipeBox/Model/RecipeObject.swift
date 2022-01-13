//
//  RecipeObject.swift
//  RecipeBox
//
//  Created by James Martin on 1/7/22.
//

import Foundation
import RealmSwift
import SwiftUI

// Getting started in Realm: https://blog.logrocket.com/getting-started-with-realmswift/
// Loading Image to Realm: https://www.educative.io/edpresso/how-to-upload-images-to-mongodb-realm-using-swiftui

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
    @Persisted var image: Data
}
