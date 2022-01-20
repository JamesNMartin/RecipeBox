//
//  RecipeDetail.swift
//  RecipeBox
//
//  Created by James Martin on 12/31/21.
//

import SwiftUI
import UIKit
import SafariServices
import CoreMotion
import RealmSwift
import Nuke
//import NukeUI

struct RecipeDetail: View {
	@EnvironmentObject var modelData: RecipeViewModel
	@State var showSafariView = false
	@ObservedObject var manager = MotionManager()
	@Environment(\.colorScheme) var colorScheme
	@Environment(\.openURL) var openURL
	var recipe: Recipe
	
	var recipeIndex: Int {
		modelData.recipes.firstIndex(where: { $0.id == recipe.id})!
	}
	
	var imageFromData: Image {
		Image(uiImage: UIImage(data: recipe.image as Data)!)
	}
	
	var body: some View {
		ScrollView(.vertical) {
			RecipeImage(image: imageFromData)
			//			Image(uiImage: UIImage(data: recipe.image as Data)!)
			//				.resizable()
			//				.ignoresSafeArea(edges: .top)
			//				.aspectRatio(contentMode: .fill)
			//				.cornerRadius(10)
			//				.frame(width: UIScreen.main.bounds.width - 24, height: UIScreen.main.bounds.width - 24, alignment: .center)
			//				.clipped()
			//				.allowsHitTesting(false)
			//				.layoutPriority(-1)
				.cornerRadius(10)
				.modifier(ParallaxMotionModifier(manager: manager, magnitude: 10))
			VStack(alignment: .leading) {
				HStack {
					Text(recipe.name)
						.font(.title)
					//.foregroundColor(Color.init(UIColor(red: 0.14, green: 0.13, blue: 0.22, alpha: 1.00)))
					if recipe.isVegan {
						Image(systemName: "leaf.fill")
							.foregroundColor(.green)
						//.font(.system(size: 12))
					}
					if recipe.isVegetarian {
						Image(systemName: "leaf")
							.foregroundColor(.green)
					}
					else {
						// NO ICON
					}
					FavoriteButton(isSet: $modelData.recipes[recipeIndex].isFavorite)
						.onChange(of: modelData.recipes[recipeIndex].isFavorite) { newValue in
							updateFavorite()
						}
				}
				HStack {
					VStack(alignment: .leading) {
						Text("Cook time: \(recipe.cookTime)")
							.font(.headline)
						//.foregroundColor(Color.init(UIColor(red: 0.45, green: 0.35, blue: 0.76, alpha: 1.00)))
						Text("Cuisine: \(recipe.cuisine)")
							.font(.headline)
						Text("Difficulty: \(recipe.difficulty)")
							.font(.headline)
						//.foregroundColor(Color.init(UIColor(red: 0.55, green: 0.53, blue: 0.79, alpha: 1.00)))
						Text("Date last made: \(recipe.dateMade.formatted(date: .long, time: .omitted))")
							.font(.headline)
						//.foregroundColor(Color.init(UIColor(red: 0.79, green: 0.77, blue: 0.81, alpha: 1.00)))
						//Divider()
					}
					//.background(.green)
					Spacer()
					Button("\(Image(systemName: "safari"))") {
						showSafariView.toggle()
					}
					.font(.largeTitle)
					.padding(.leading)
					.foregroundColor(Color.accentColor)
					//.background(.red)
					.sheet(isPresented: $showSafariView) {
						SafariView(url: URL(string: recipe.url)!)
					}
				}
				//.background(.blue)
				.font(.subheadline)
				.foregroundColor(.secondary)
				Divider()
				Text("Notes:")
					.font(.title2)
				//.padding(.bottom)
				Text(recipe.notes)
				//.font(.headline)
					.fontWeight(.regular)
			}
			//.background(.orange)
			.padding()
		}
		.navigationBarTitleDisplayMode(.inline)
		.navigationTitle(recipe.name)
	}
	func updateFavorite() {
		do {
			let realm = try Realm()
			let objectId = try ObjectId(string: recipe.id)
			let recipe = realm.object(ofType: RecipeObject.self, forPrimaryKey: objectId)
			try realm.write {
				recipe?.isFavorite = modelData.recipes[recipeIndex].isFavorite
			}
		} catch let error {
			print(error.localizedDescription)
		}
	}}
struct ParallaxMotionModifier: ViewModifier {
	
	@ObservedObject var manager: MotionManager
	var magnitude: Double
	
	func body(content: Content) -> some View {
		content
			.offset(x: CGFloat(manager.roll * magnitude), y: CGFloat(manager.pitch * magnitude))
	}
}
class MotionManager: ObservableObject {
	
	@Published var pitch: Double = 0.0
	@Published var roll: Double = 0.0
	
	private var manager: CMMotionManager
	
	init() {
		self.manager = CMMotionManager()
		self.manager.deviceMotionUpdateInterval = 1/60
		self.manager.startDeviceMotionUpdates(to: .main) { (motionData, error) in
			guard error == nil else {
				print(error!)
				return
			}
			
			if let motionData = motionData {
				self.pitch = motionData.attitude.pitch
				self.roll = motionData.attitude.roll
			}
		}
		
	}
}

struct RecipeDetail_Previews: PreviewProvider {
	static let modelData = RecipeViewModel()
	
	static var previews: some View {
		RecipeDetail(recipe: modelData.recipes[0])
			.environmentObject(modelData)
	}
}
