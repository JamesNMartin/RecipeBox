//
//  FloatingMenu.swift
//  RecipeBox
//
//  Created by James Martin on 2/2/22.
//

import SwiftUI

struct FloatingMenu: View {
	
	@State var showMenuItem1 = false
	@State var showMenuItem2 = false
	@State var showMenuItem3 = false
	
	var body: some View {
		VStack {
			Spacer()
			if showMenuItem1 {
				MenuItem(icon: "pencil")
			}
			if showMenuItem2 {
				MenuItem(icon: "trash")
			}
			if showMenuItem3 {
				MenuItem(icon: "square.and.arrow.up")
			}
			Button(action: {
				self.showMenu()
			}) {
				Image(systemName: "plus.circle.fill")
					.resizable()
					.frame(width: 70, height: 70)
					.foregroundColor(Color.accentColor)
				//.shadow(color: .gray, radius: 0.2, x: 1, y: 1)
			}
		}
	}
	func showMenu() {
		withAnimation {
			self.showMenuItem3.toggle()
		}
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
			withAnimation {
				self.showMenuItem2.toggle()
			}
		})
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
			withAnimation {
				self.showMenuItem1.toggle()
			}
		})
	}
}
struct MenuItem: View {
	
	var icon: String
	var body: some View {
		ZStack {
			Circle()
				.foregroundColor(Color.accentColor)
				.frame(width: 45, height: 45)
			Image(systemName: icon)
				.imageScale(.large)
				.foregroundColor(.white)
		}
		//.shadow(color: .gray, radius: 0.2, x: 1, y: 1)
		//.transition(.move(edge: .trailing))
	}
}
struct FloatingMenu_Previews: PreviewProvider {
	static var previews: some View {
		FloatingMenu()
	}
}
