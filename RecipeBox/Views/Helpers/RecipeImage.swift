//
//  RecipeImage.swift
//  RecipeBox
//
//  Created by James Martin on 1/9/22.
//

import SwiftUI
import Nuke

struct RecipeImage: View {
    @ObservedObject var nukeImage: FetchImage
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .ignoresSafeArea(edges: .top)
            .aspectRatio(1.0, contentMode: .fill)
            //.scaledToFit()
            .cornerRadius(10)
            .frame(width: UIScreen.main.bounds.width - 24, height: UIScreen.main.bounds.width - 24, alignment: .center)
        //.background(Color.clear)
        //.shadow(color: Color.gray, radius: 4, x: 0, y: 0)
    }
}

struct RecipeImage_Previews: PreviewProvider {
    static var previews: some View {
        RecipeImage(image: Image("rainbow"))
    }
}
