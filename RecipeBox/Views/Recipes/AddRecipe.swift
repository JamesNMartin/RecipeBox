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

struct AddRecipe: View {
    @State private var name: String = ""
    @State private var cookTime: String = ""
    @State private var descriptionText: String = ""
    @State private var url: String = ""
    @State private var hour: String = ""
    @State private var pMode: String = ""
    @State private var minute: String = ""
    @State private var isVegan: Bool = false
    @State private var date = Date()
    @State private var difficulty: String = "Low"
    @State private var showingDetail = false
    @State private var allowSaving = false
    @State private var selectedMinutes = "0 Minutes"
    private var minutes = ["0 Minutes", "15 Minutes", "30 Minutes", "45 Minutes"]
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
                        Button("\(Image(systemName: "camera.fill"))") {
                            self.sourceType = .photoLibrary
                            self.isImagePickerDisplay.toggle()
                            
                        }
                        .pickerStyle(.menu)
                        .font(.system(size: 24))
                    }
                }
                //TextField("Name", text: $name)
                //TextField("Cook time", text: $cookTime)
                Section(header: Text("Cook time"), footer: Text("You can use this as cook time or prep time.")) {
                    HStack {
                        Text("Hours")
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
                Section(header: Text("Tags"), footer: Text("Using tags will help when searching for recipes")) {
                    Toggle(isOn: $isVegan) {
                        Text("Vegan")
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
                    TextField("URL", text: $url)
                }
                Section(header: Text("Notes"), footer: Text("Jot down any notes, thoughts, or anything you might want to change in the recipe")) {
                    TextEditor(text: $descriptionText)
                }
            }
            .navigationTitle("Add Meal")
            .sheet(isPresented: self.$isImagePickerDisplay) {
                ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
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
        //guard let image = selectedImage else { return }
        // Found here: https://www.codegrepper.com/code-examples/swift/uiimage+to+data+swift
        // More: https://stackoverflow.com/questions/32297704/convert-uiimage-to-nsdata-and-convert-back-to-uiimage-in-swift
        guard let imageData = selectedImage?.jpegData(compressionQuality: 0.0) else { return }
        //let jpegData = imageData.jpegData(compressionQuality: 0.0)
        
        
        realmData.addRecipe(name: $name.wrappedValue, notes: $descriptionText.wrappedValue, isFavorite: false, difficulty: $difficulty.wrappedValue, dateMade: date, cookTime: "\($hour.wrappedValue) Hours \($minute.wrappedValue)", isVegan: isVegan, url: $url.wrappedValue, image: imageData)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddRecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipe()
    }
}
