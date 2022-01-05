//
//  RecipeDetail.swift
//  RecipeBox
//
//  Created by James Martin on 12/31/21.
//

import SwiftUI
import SafariServices
import CoreMotion

struct RecipeDetail: View {
    @EnvironmentObject var modelData: ModelData
    @State var showSafariView = false
    @ObservedObject var manager = MotionManager()
    @Environment(\.openURL) var openURL
    var recipe: Recipe
    
    var recipeIndex: Int {
        modelData.recipes.firstIndex(where: { $0.id == recipe.id})!
    }
    
    var body: some View {
        ScrollView {
            recipe.image
                .resizable()
                .ignoresSafeArea(edges: .top)
                .frame(width: UIScreen.main.bounds.width - 24, height: UIScreen.main.bounds.width - 16, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .clipped()
                .cornerRadius(10)
                .background(Color.clear)
                //.shadow(color: Color.gray, radius: 4, x: 0, y: 0)
                .modifier(ParallaxMotionModifier(manager: manager, magnitude: 10))
            VStack(alignment: .leading) {
                HStack {
                    Text(recipe.name)
                        .font(.title)
                    if recipe.isVegan {
                        Image(systemName: "leaf.fill")
                            .foregroundColor(.green)
                        //.font(.system(size: 12))
                    } else {
                        Image(systemName: "leaf.fill")
                            .hidden()
                    }
                    FavoriteButton(isSet: $modelData.recipes[recipeIndex].isFavorite)
                    
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Cook time: \(recipe.cookTime)")
                            .font(.headline)
                        Text("Difficulty: \(recipe.difficulty)")
                            .font(.headline)
                            .font(.headline)
                        Text("Date last made: \(recipe.dateMade)")
                            .font(.headline)
                        //Divider()
                        
                    }
                    Spacer()
                    Link(destination: URL(string: recipe.url)!) {
                        Image(systemName: "safari")
                            .font(.largeTitle)
                            .padding(.leading)
                            .foregroundColor(Color.accentColor)
                    }
                    //Text(recipe.url)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text("Notes:")
                    .font(.title2)
                //.padding(.bottom)
                Text(recipe.description)
                    //.font(.headline)
                    .fontWeight(.regular)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(recipe.name)
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
    static let modelData = ModelData()
    
    static var previews: some View {
        RecipeDetail(recipe: modelData.recipes[0])
            .environmentObject(modelData)
    }
}
