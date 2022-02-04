//
//  ModifyRecipe.swift
//  RecipeBox
//
//  Created by James Martin on 2/2/22.
//

import SwiftUI

struct ModifyRecipe: View {
	@State var name: String = ""
	@State var cookTime: String = ""
	@State var descriptionText: String = ""
	@State var ingredientsText: String = "\u{2022} " // BULLET UNICODE \u{2022}
	@State var url: String = ""
	@State private var hour: String = ""
	@State private var minute: String = ""
	@State var cuisine: String = "American"
	@State var servingSize: Int = 1
	@State var isVegan: Bool = false
	@State var isVegetarian: Bool = false
	@State var date = Date()
	@State var numberOfTimesMade: Int = 0
	@State var difficulty: String = "Low"
	@State var showingDetail = false
	@State var showingWebView = false
	@State var selectedMinutes = "0 Minutes"
	@State var image: Data
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
			.navigationBarTitle("Detail", displayMode: .inline)
			.toolbar() {
				
			}
		}
    }
//	func setImage() {
//		var imageFromData: UIImage {
//			UIImage(data: image as Data)!
//		}
//	}
}

//struct ModifyRecipe_Previews: PreviewProvider {
//    static var previews: some View {
//        ModifyRecipe()
//    }
//}
