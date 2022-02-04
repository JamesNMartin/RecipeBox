//
//  AddRecipe.swift
//  RecipeBox
//
//  Created by James Martin on 1/1/22.
//

import SwiftUI
import UIKit
import Foundation
import Combine
import AssetsLibrary
import SafariServices

struct AddRecipe: View {
	@State private var name: String = ""
	@State private var cookTime: String = ""
	@State private var descriptionText: String = ""
	//@State private var ingredients: String = ""
	@State var ingredientsText: String = "\u{2022} " // BULLET UNICODE \u{2022}
	@State private var url: String = ""
	@State private var hour: String = ""
	@State private var minute: String = ""
	@State private var cuisine: String = "American"
	@State private var servingSize: Int = 1
	@State private var isVegan: Bool = false
	@State private var isVegetarian: Bool = false
	@State private var date = Date()
	@State private var numberOfTimesMade: Int = 0
	@State private var difficulty: String = "Low"
	@State private var showingDetail = false
	@State private var showingWebView = false
	@State private var selectedMinutes = "0 Minutes"
	//@FocusState private var focusedField: Field?
	private var minutes = ["0 Minutes", "15 Minutes", "30 Minutes", "45 Minutes"]
	private var cuisines = ["French","Chinese","Japanese","Italian","Greek","Spanish","Mediterranean","Lebanese","Moroccan","Turkish","Thai","Indian","Cajun","Mexican","Caribbean","German","Russian","Hungarian","American"]
	@Environment(\.presentationMode) var presentationMode
	@EnvironmentObject var realmData: RecipeViewModel
	
	@State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
	@State private var selectedImage: UIImage?
	@State private var isImagePickerDisplay = false
	
	var body: some View {
		NavigationView {
			List {
				Section(header: Text("Recipe Name")) {
					TextField("Name", text: $name)
				}
				Section(header: Text("Recipe Image")) {
					HStack {
						
						if selectedImage != nil {
							Image(uiImage: selectedImage!)
								.resizable()
								.aspectRatio(contentMode: .fit)
								.cornerRadius(10)
							//.clipShape(Circle())
								.frame(width: 75, height: 75)
						} else {
							Image(systemName: "square.dashed")
								.resizable()
								.aspectRatio(contentMode: .fit)
								.foregroundColor(Color.accentColor)
								.cornerRadius(10)
								.opacity(0.3)
							//.clipShape(Circle())
								.frame(width: 75, height: 75)
						}
						Spacer()
						Button("\(Image(systemName: "photo.on.rectangle"))") {
							self.sourceType = .photoLibrary
							self.isImagePickerDisplay.toggle()
							
						}
						.pickerStyle(.menu)
						.font(.system(size: 24))
					}
				}
				Section(header: Text("Cook time"), footer: Text("You can use this as cook time or prep time.")) {
					HStack {
						Text("Hour(s)")
						Spacer()
						Picker(selection: $hour, label: Text("Hours")) {
							ForEach((0 ..< 13).map(String.init), id:\.self) { i in
								Text("\(i) Hours")
							}
						}
						.pickerStyle(.menu)
					}
					HStack {
						Text("Minutes")
						Spacer()
						Picker(selection: $minute, label: Text("Minutes")) {
							ForEach(minutes, id: \.self, content: { minute in
								Text(minute)
							})
						}
						.pickerStyle(.menu)
					}
				}
				Section(header: Text("Cuisine and Serving Size")) {
					Picker ("Cuisine", selection: $cuisine) {
						ForEach(cuisines, id: \.self) {
							Text($0)
						}
					}
					Stepper("Serving Size: \(servingSize)", value: $servingSize, in: 1...24)
				}
				Section(header: Text("Tags"), footer: Text("Using tags will help when searching for recipes")) {
					Toggle(isOn: $isVegan) {
						Text("Vegan")
					}
					.tint(Color.accentColor)
					Toggle(isOn: $isVegetarian) {
						Text("Vegetarian")
					}
					.tint(Color.accentColor)
				}
				Picker(selection: $difficulty, label: Text("Recipe Difficulty")) {
					let levels = ["Low", "Medium", "High"]
					ForEach(levels, id: \.self, content: { level in
						Text(level)
					})
				}
				.pickerStyle(.inline)
				Section(header: Text("Date Made")) {
					DatePicker("Date Made",selection: $date,displayedComponents: [.date])
				}
				Section(header: Text("Recipe site (Optional)"), footer: Text("You can optionally add the site you found the recipe on. If it's a recipe you created then you can leave this blank")) {
					HStack {
						TextField("URL", text: $url)
						//Image(systemName: "exclamationmark.triangle.fill")
					}
					Button("Open site to copy ingredients") {
						// MAKE SURE URL IS VALID BEFORE ENABLING BUTTON
						showingWebView.toggle()
					}
					.sheet(isPresented: $showingWebView) {
						SafariView(url: URL(string: $url.wrappedValue)!)
					}
				}
				Section(header: Text("Ingredients (Optional)"), footer: Text("Add ingredients list to dinner")) {
					TextEditor(text: $ingredientsText)
						.onChange(of: ingredientsText) { [ingredientsText] newText in
							if newText.suffix(1) == "\n" && newText > ingredientsText {
								self.ingredientsText.append("\u{2022} ")
							}
						}
				}
				Section(header: Text("Notes (Optional)"), footer: Text("Jot down any notes, thoughts, or anything you might want to change in the recipe")) {
					TextEditor(text: $descriptionText)
				}
			}
			.navigationTitle("Add Recipe")
			.sheet(isPresented: self.$isImagePickerDisplay) {
				ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
			}
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Button("Done") {
						hideKeyboard()
					}
					Spacer()
				}
				ToolbarItemGroup(placement: .navigationBarLeading) {
					Button(action: {
						//Dismiss view
						
						presentationMode.wrappedValue.dismiss()
					}, label: {
						Text("Cancel")
							.fontWeight(.bold)
						//Image(systemName: "line.3.horizontal.decrease.circle")
					})
				}
				ToolbarItemGroup(placement: .navigationBarTrailing) {
					Button(action: {
						handleSubmit()
						
					}, label: {
						Text("Save")
						//Image(systemName: "line.3.horizontal.decrease.circle")
					})
				}
			}
		}
	}
	private func handleSubmit() {
		
		var formattedCookTime = ""
		if $hour.wrappedValue == "" || $hour.wrappedValue == "0" {
			formattedCookTime = $minute.wrappedValue
		} else {
			if $hour.wrappedValue == "1" {
				formattedCookTime = "\($hour.wrappedValue) Hour \($minute.wrappedValue)"
			} else {
				formattedCookTime = "\($hour.wrappedValue) Hours \($minute.wrappedValue)"
			}
		}
		
		//		USES THE EXTENSION BELOW (UIIMAGE) ***********************************************************************
		let image = selectedImage!// your image
		let targetSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
		
		let scaledImage = image.scalePreservingAspectRatio(
			targetSize: targetSize
		)
		guard let imageData = scaledImage.jpegData(compressionQuality: 1.0) else { return }
		
		// MIGHT USE MARKDOWN FOR DESCRIPTION AND NOTES
		//var markdownText: AttributedString = try! AttributedString(markdown: descriptionText)
		
		realmData.addRecipe(name: $name.wrappedValue, notes: $descriptionText.wrappedValue, ingredients: $ingredientsText.wrappedValue, isFavorite: false,
							difficulty: $difficulty.wrappedValue, servingSize: servingSize, dateMade: date,
							cookTime: formattedCookTime,
							isVegan: isVegan, isVegetarian: isVegetarian, cuisine: $cuisine.wrappedValue, numberOfTimesMade: 0, url: $url.wrappedValue, image: imageData)
		presentationMode.wrappedValue.dismiss()
	}
}

struct AddRecipe_Previews: PreviewProvider {
	static var previews: some View {
		AddRecipe()
	}
}
struct SafariView: UIViewControllerRepresentable {
	
	let url: URL
	
	func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
		return SFSafariViewController(url: url)
	}
	
	func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
		
	}
	
}
extension UIImage {
	func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
		// Determine the scale factor that preserves aspect ratio
		let widthRatio = targetSize.width / size.width
		let heightRatio = targetSize.height / size.height
		
		let scaleFactor = min(widthRatio, heightRatio)
		
		// Compute the new image size that preserves aspect ratio
		let scaledImageSize = CGSize(
			width: size.width * scaleFactor,
			height: size.height * scaleFactor
		)
		
		// Draw and return the resized UIImage
		let renderer = UIGraphicsImageRenderer(
			size: scaledImageSize
		)
		
		let scaledImage = renderer.image { _ in
			self.draw(in: CGRect(
				origin: .zero,
				size: scaledImageSize
			))
		}
		
		return scaledImage
	}
}
#if canImport(UIKit)
extension View {
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
#endif
