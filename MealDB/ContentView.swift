//
//  ContentView.swift
//  MealDB
//
//  Created by Jon Grimes on 8/6/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DessertView()
                .tabItem { Label("Desserts", systemImage: "birthday.cake") }
            MealsView()
                .tabItem { Label("Meals", systemImage: "fork.knife") }
        }
    }
}

#Preview {
    ContentView()
}
