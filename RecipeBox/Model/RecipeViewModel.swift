//
//  RecipeViewModel.swift
//  RecipeBox
//
//  Created by James Martin on 1/7/22.
//
// REALLY GOOD REALM SWIFT TUT. ITS WHAT I USED TO START THIS APP
//  https://blog.logrocket.com/getting-started-with-realmswift/

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
	func addRecipe (name: String, notes: String, ingredients: String, isFavorite: Bool, difficulty: String, servingSize: Int, dateMade: Date, cookTime: String, isVegan: Bool, isVegetarian: Bool, cuisine: String, numberOfTimesMade: Int,  url: String, image: Data) {
        
        let recipeObject = RecipeObject(value: [
            "name": name,
            "notes": notes,
			"ingredients": ingredients,
            "isFavorite": false,
            "difficulty": difficulty,
			"servingSize": servingSize,
            "dateMade": dateMade,
            "cookTime": cookTime,
            "isVegan": isVegan,
			"isVegetarian": isVegetarian,
			"cuisine": cuisine,
			"numberOfTimesMade": numberOfTimesMade,
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
	func remove(id: String) {
		do {
			let realm = try Realm()
			let objectId = try ObjectId(string: id)
			if let recipe = realm.object(ofType: RecipeObject.self, forPrimaryKey: objectId) {
				try realm.write {
					realm.delete(recipe)
				}
			}
		} catch let error {
			print(error.localizedDescription)
		}
	}
	func updateLastDateMade(id: String) {
		do {
			let realm = try Realm()
			let objectId = try ObjectId(string: id)
			if let recipe = realm.object(ofType: RecipeObject.self, forPrimaryKey: objectId) {
				try realm.write {
					recipe.dateMade = Date.now
				}
			}
		} catch let error {
			print(error.localizedDescription)
		}
	}
	func updateNumberOfTimesMade(id: String) {
		do {
			let realm = try Realm()
			let objectId = try ObjectId(string: id)
			if let recipe = realm.object(ofType: RecipeObject.self, forPrimaryKey: objectId) {
				try realm.write {
					recipe.numberOfTimesMade+=1
				}
			}
		} catch let error {
			print(error.localizedDescription)
		}
	}
	func updateFavorite(id: String) {
		do {
			let realm = try Realm()
			let objectId = try ObjectId(string: id)
			let recipe = realm.object(ofType: RecipeObject.self, forPrimaryKey: objectId)
			try realm.write {
				recipe?.isFavorite.toggle()
			}
		} catch {
			print(error.localizedDescription)
		}
	}
//	func updateTitle(id: String, newTitle: String) {
//		do {
//			let realm = try Realm()
//			let objectId = try ObjectId(string: id)
//			let task = realm.object(ofType: RecipeObject.self, forPrimaryKey: objectId)
//			try realm.write {
//				task?.title = newTitle
//			}
//		} catch let error {
//			print(error.localizedDescription)
//		}
//	}
}
