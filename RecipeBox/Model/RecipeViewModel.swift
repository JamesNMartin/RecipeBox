//
//  RecipeViewModel.swift
//  RecipeBox
//
//  Created by James Martin on 1/7/22.
//

import Foundation
import Combine
import RealmSwift

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
    func addRecipe (name: String, notes: String, isFavorite: Bool, difficulty: String, dateMade: Date, cookTime: String, isVegan: Bool, url: String, imageName: String) {
        let recipeObject = RecipeObject(value: [
            "name": name,
            "notes": notes,
            "isFavorite": false,
            "difficulty": difficulty,
            "dateMade": dateMade,
            "cookTime": cookTime,
            "isVegan": isVegan,
            "url": url,
            "imageName": imageName
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
