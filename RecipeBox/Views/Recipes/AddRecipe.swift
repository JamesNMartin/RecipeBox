//
//  AddRecipe.swift
//  RecipeBox
//
//  Created by James Martin on 1/1/22.
//

import SwiftUI

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
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            List {
                HStack {
                    TextField("Name", text: $name)
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "photo.on.rectangle.angled")
                            .font(.system(size: 20))
                    })
                }
                //TextField("Name", text: $name)
                //TextField("Cook time", text: $cookTime)
                Section(header: Text("\(Image(systemName: "hourglass")) Cook time")) {
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
                Section(header: Text("\(Image(systemName: "tag")) Tags")) {
                    Toggle(isOn: $isVegan) {
                        Text("Vegan")
                    }
                    .tint(Color.accentColor)
                }
                Picker(selection: $selection, label: Text("\(Image(systemName: "exclamationmark.triangle.fill")) Difficulty")) {
                    Text("Low").tag(1)
                    Text("Medium").tag(2)
                    Text("Hard").tag(3)
                }
                .pickerStyle(.inline)
                Section(header: Text("\(Image(systemName: "calendar")) Date Made")) {
                    DatePicker("Date Made",selection: $date,displayedComponents: [.date])
                }
                Section(header: Text("\(Image(systemName: "link")) Recipe site (Optional)")) {
                    TextField("URL", text: $url)
                }
                Section(header: Text("\(Image(systemName: "note")) Notes")) {
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
                        // Save action
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
