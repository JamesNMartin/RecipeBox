//
//  RecipeViewModel.swift
//  RecipeBox
//
//  Created by James Martin on 1/7/22.
//

import Foundation
import Combine
import RealmSwift
import UIKit
import SwiftUI

final class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    
    private var token: NotificationToken?
    
    init() {
        setupObserver()
    }
    
    deinit {
        token?.invalidate()
    }
    
    private func setupObserver() {
        do {
            let realm = try Realm()
            let results = realm.objects(RecipeObject.self)
            
            token = results.observe({ [weak self] changes in
                self?.recipes = results.map(Recipe.init)
            })
        } catch let error {
            print(error.localizedDescription)
        }
    }
	func addRecipe (name: String, notes: String, isFavorite: Bool, difficulty: String, dateMade: Date, cookTime: String, isVegan: Bool, isVegetarian: Bool, cuisine: String, url: String, image: Data) {
        
        let recipeObject = RecipeObject(value: [
            "name": name,
            "notes": notes,
            "isFavorite": false,
            "difficulty": difficulty,
            "dateMade": dateMade,
            "cookTime": cookTime,
            "isVegan": isVegan,
			"isVegetarian": isVegetarian,
			"cuisine": cuisine,
            "url": url,
            //"imageName": imageName
            "image": image
        ])
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(recipeObject)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
