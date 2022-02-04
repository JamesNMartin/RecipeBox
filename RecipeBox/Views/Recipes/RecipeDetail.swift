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

struct RecipeDetail: View {
	@EnvironmentObject private var modelData: RecipeViewModel
	@State var showSafariView = false
	@State private var presentAlert = false
	@State private var showingSheet = false
	@ObservedObject var manager = MotionManager()
	@Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
	@Environment(\.colorScheme) var colorScheme
	@Environment(\.openURL) var openURL
	var recipe: Recipe
	
	//	var recipeIndex: Int {
	//		modelData.recipes.firstIndex(where: { $0.id == recipe.id})!
	//	}
	var favoriteStatus: Bool {
		recipe.isFavorite
	}
	var imageFromData: Image {
		Image(uiImage: UIImage(data: recipe.image as Data)!)
	}
	var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			ZStack {
				RecipeImage(image: imageFromData)
					.cornerRadius(10)
					.modifier(ParallaxMotionModifier(manager: manager, magnitude: 5))
				VStack(alignment: .leading) {
					Spacer()
					HStack {
						Text(recipe.name)
							.font(.system(.title, design: .rounded).bold())
							.foregroundColor(.white)
						//.font(.title).bold()
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
					}
					HStack {
						VStack(alignment: .leading) {
							Text("Cook time: \(recipe.cookTime)")
								.font(.headline)
								.foregroundColor(.white)
							//.foregroundColor(Color.init(UIColor(red: 0.45, green: 0.35, blue: 0.76, alpha: 1.00)))
							Text("Cuisine: \(recipe.cuisine)")
								.font(.headline)
								.foregroundColor(.white)
							Text("Difficulty: \(recipe.difficulty)")
								.font(.headline)
								.foregroundColor(.white)
							//.foregroundColor(Color.init(UIColor(red: 0.55, green: 0.53, blue: 0.79, alpha: 1.00)))
							Text("Date last made: \(recipe.dateMade.formatted(date: .long, time: .omitted))")
								.font(.headline)
								.foregroundColor(.white)
							//.foregroundColor(Color.init(UIColor(red: 0.79, green: 0.77, blue: 0.81, alpha: 1.00)))
							//Divider()
						}
						Spacer()
						Button("\(Image(systemName: "safari"))") {
							showSafariView.toggle()
						}
						.font(.largeTitle)
						.padding(.leading)
						.foregroundColor(.white)
						.sheet(isPresented: $showSafariView) {
							SafariView(url: URL(string: recipe.url)!)
						}
					}
					.font(.subheadline)
					.foregroundColor(.secondary)
				}
				.modifier(ParallaxMotionModifier(manager: manager, magnitude: 10))
			}
			//.shadow(color: Color.init(UIColor(named: "Image-Shadow-Color")!), radius: 8, x: 0, y: 0)
			.padding()
			.frame(width: UIScreen.main.bounds.width - 24, height: UIScreen.main.bounds.width - 24, alignment: .center)
			HStack {
				VStack (alignment: .leading) {
					ScrollView(.horizontal, showsIndicators: false) {
						HStack {
							DetailCube(titleText: "Made", subTitleText: formatMadeText(), cubeColor: Color.init(UIColor(named: "Black-5")!))
							DetailCube(titleText: "Serving Size", subTitleText: "\(recipe.servingSize)", cubeColor: Color.init(UIColor(named: "Black-4")!))
							// NOT IDEAL BUT I WAS TOO LAZY TO MAKE IT NICE
							Rectangle()
								.fill(Color.init(UIColor(named: "Black-3")!))
								.frame(width: 100, height: 60)
								.cornerRadius(10)
								.overlay(
									HStack (alignment: .center, spacing: 0) {
										VStack (alignment: .center) {
											Text("Favorite")
												.font(.system(size: 16, weight: .regular, design: .rounded).bold())
											Button("\(Image(systemName: favoriteStatus ? "heart.fill" : "heart"))") {
												updateFavorite()
											}
											.imageScale(.large)
											.foregroundColor(favoriteStatus ? .red : .gray)
										}
									})
							DetailCube(titleText: "Diet", subTitleText: getDiet(), cubeColor: Color.init(UIColor(named: "Black-2")!))
							Divider()
							Rectangle()
								.fill(Color.init(UIColor(named: "Action-Buttons-Color")!))
								.frame(width: 100, height: 60)
								.cornerRadius(10)
								.overlay(
									HStack (alignment: .center, spacing: 0) {
										VStack (alignment: .center) {
											Text("Make This")
												.font(.system(size: 16, weight: .regular, design: .rounded).bold())
											Button("\(Image(systemName: "checkmark.circle"))") {
												incrementNumberOfTimesMade()
											}
											.imageScale(.large)
										}
									})
							Rectangle()
								.fill(Color.init(UIColor(named: "Action-Buttons-Color")!))
								.frame(width: 100, height: 60)
								.cornerRadius(10)
								.overlay(
									HStack (alignment: .center, spacing: 0) {
										VStack (alignment: .center) {
											Text("Modify")
												.font(.system(size: 16, weight: .regular, design: .rounded).bold())
											Button("\(Image(systemName: "ellipsis.circle"))") {
												/// WE WILL PRESENT A VIEW VERY SIMILAR TO ADD RECIPE BUT WITH
												/// ALL CURRENT INFO HELD AND UPDATEABLE.
												showingSheet = true
											}
											.imageScale(.large)
										}
									})
							Rectangle()
								.fill(Color.init(UIColor(named: "Action-Buttons-Color")!))
								.frame(width: 100, height: 60)
								.cornerRadius(10)
								.overlay(
									HStack (alignment: .center, spacing: 0) {
										VStack (alignment: .center) {
											Text("Share")
												.font(.system(size: 16, weight: .regular, design: .rounded).bold())
											Button("\(Image(systemName: "square.and.arrow.up"))") {
												/// WE WILL PRESENT A VIEW VERY SIMILAR TO ADD RECIPE BUT WITH
												/// ALL CURRENT INFO HELD AND UPDATEABLE.
												showingSheet = true
											}
											.imageScale(.large)
										}
									})
							Rectangle()
								.fill(Color.init(UIColor(named: "Delete-Button-Color")!))
								.frame(width: 100, height: 60)
								.cornerRadius(10)
								.overlay(
									HStack (alignment: .center, spacing: 0) {
										VStack (alignment: .center) {
											Text("Delete")
												.font(.system(size: 16, weight: .regular, design: .rounded).bold())
											Button("\(Image(systemName: "trash"))") {
												//delete()
												presentAlert = true
											}
											.alert("Are you sure you want to delete this recipe?", isPresented: $presentAlert, actions: {
												Button("Cancel", role: .cancel, action: {})
												Button("Delete", role: .destructive, action: {delete()})
											}, message: {
												//Text("")
											})
											.imageScale(.large)
										}
									})
						}
					}
					.frame(width: UIScreen.main.bounds.width - 24)
					Divider()
					Text("Ingredients:")
						.font(.system(.title2, design: .rounded).bold())
					Text(recipe.ingredients)
						.fontWeight(.regular)
					Spacer()
					Text("Notes:")
						.font(.system(.title2, design: .rounded).bold())
					Text(recipe.notes)
						.fontWeight(.regular)
				}
				//Spacer() // DUDE I DONT EVEN KNOW. THIS WAS NEEDED AT ONE POINT BUT REMOVING IT FIXED A DIFFERNT ISSUE
			}
			.padding()
		}
		.sheet(isPresented: $showingSheet) {
			//ModifyRecipe()
		}
		.navigationBarTitle("Detail", displayMode: .inline)
		.toolbar {
			//				ToolbarItemGroup() {
			//					Button("\(Image(systemName: "trash"))") {
			//						delete()
			//					}
			//				}
		}
		//Floating button here but its not going all the way to the bottom
		
	}
	private func formatMadeText() -> String {
		var madeText = ""
		if recipe.numberOfTimesMade == 0 {
			madeText = "Zero"
		}
		if recipe.numberOfTimesMade > 0 {
			madeText = "\(recipe.numberOfTimesMade)x"
		}
		return madeText
	}
	private func getDiet() -> String {
		var diet = ""
		if !recipe.isVegan && !recipe.isVegetarian {
			diet = "None"
		}
		if recipe.isVegan {
			diet = "Vegan"
		}
		if recipe.isVegetarian {
			diet = "Veggie"
		}
		return diet
	}
	private func incrementNumberOfTimesMade() {
		modelData.updateNumberOfTimesMade(id: recipe.id)
		modelData.updateLastDateMade(id: recipe.id)
		
	}
	private func delete() {
		modelData.remove(id: recipe.id)
		presentationMode.wrappedValue.dismiss()
	}
	private func updateFavorite() {
		modelData.updateFavorite(id: recipe.id)
	}
}

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
		self.manager.deviceMotionUpdateInterval = 1/120
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
