/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A button that acts as a favorites indicator.
*/

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool

    var body: some View {
		Button("\(Image(systemName: isSet ? "star.fill" : "star"))") {
			isSet.toggle()
		}
		.imageScale(.large)
		.foregroundColor(isSet ? .yellow : .gray)
//        Button {
//            isSet.toggle()
//        } label: {
//            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
//                .labelStyle(.iconOnly)
//				.foregroundColor(isSet ? .yellow : .gray)
//        }
    }
}

//struct FavoriteButton_Previews: PreviewProvider {
//    static var previews: some View {
//        //FavoriteButton(isSet: .constant(true))
//    }
//}
