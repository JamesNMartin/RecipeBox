//
//  RecipeImage.swift
//  RecipeBox
//
//  Created by James Martin on 1/9/22.
//

import SwiftUI
//import NukeUI
//import Nuke
import RealmSwift

struct RecipeImage: View {
    var image: Image
	
    var body: some View {
		image
            .resizable()
            .ignoresSafeArea(edges: .top)
			.aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width - 24, height: UIScreen.main.bounds.width - 24, alignment: .center)
			.clipped()
			.allowsHitTesting(false)
			.layoutPriority(-1)
    }
}

struct RecipeImage_Previews: PreviewProvider {
    static var previews: some View {
        RecipeImage(image: Image("rainbow"))
    }
}
