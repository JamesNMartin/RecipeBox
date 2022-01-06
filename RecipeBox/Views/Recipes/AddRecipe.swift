//
//  AddRecipe.swift
//  RecipeBox
//
//  Created by James Martin on 1/1/22.
//

import SwiftUI
import Foundation

struct AddRecipe: View {
    @State private var name: String = ""
    @State private var cookTime: String = ""
    @State private var descriptionText: String = ""
    @State private var url: String = ""
    @State private var hour: String = ""
    @State private var minute: String = ""
    @State private var isVegan: Bool = false
    @State private var date = Date()
    @State private var selection = 1
    @State private var showingDetail = false
    @State private var allowSaving = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var jsonData: ModelData
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Recipe Name and image")) {
                    HStack {
                        TextField("Name", text: $name)
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.system(size: 20))
                        })
                    }
                }
                //TextField("Name", text: $name)
                //TextField("Cook time", text: $cookTime)
                Section(header: Text("Cook time"), footer: Text("You can use this as cook time or prep time.")) {
                    HStack {
                        Text("Hours")
                        Spacer()
                        Picker(selection: $hour, label: Text("Hours")) {
                            ForEach(0 ..< 13) {
                                Text("\($0) Hours")
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    HStack {
                        Text("Minutes")
                        Spacer()
                        Picker(selection: $minute, label: Text("Minutes")) {
                            Text("0 Minutes").tag(1)
                            Text("15 Minutes").tag(2)
                            Text("30 Minutes").tag(3)
                            Text("45 Minutes").tag(4)
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
                Picker(selection: $selection, label: Text("Recipe Difficulty")) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("Hard").tag(3)
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
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button(action: {
                        //Dismiss view
                    }, label: {
                        Text("Dismiss")
                            .fontWeight(.bold)
                        //Image(systemName: "line.3.horizontal.decrease.circle")
                    })
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        
                    }, label: {
                        Text("Save")
                        //Image(systemName: "line.3.horizontal.decrease.circle")
                    })
                }
            }
        }
    }
}

struct AddRecipe_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipe()
    }
}
