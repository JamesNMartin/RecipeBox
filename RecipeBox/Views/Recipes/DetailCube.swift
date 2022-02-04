//
//  DetailCube.swift
//  RecipeBox
//
//  Created by James Martin on 1/25/22.
//

import SwiftUI

struct DetailCube: View {
	
	var titleText: String
	var subTitleText: String
	var cubeColor: Color
	
	var body: some View {
		Rectangle()
			.fill(cubeColor)
			.frame(width: 100, height: 60)
			.cornerRadius(10)
			.overlay(
				HStack (alignment: .center, spacing: 0) {
					VStack (alignment: .center) {
						Text(titleText)
							.font(.system(size: 16, weight: .regular, design: .rounded).bold())
						//.font(.system(size: 12))
						Text(subTitleText)
							.font(.system(size: 18, weight: .regular, design: .rounded))
						//.font(.system(size: 16))
					}
				})
	}
}
//struct DetailCube_Previews: PreviewProvider {
//	static var previews: some View {
//		DetailCube()
//	}
//}
