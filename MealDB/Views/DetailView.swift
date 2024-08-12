//
//  DetailView.swift
//  MealDB
//
//  Created by Jon Grimes on 8/9/24.
//

import SwiftUI

struct DetailView: View {
    var meal: Meal
    
    var body: some View {
        ScrollView {
            VStack {
                // Image
                if let imgurl = meal.imgURL {
                    AsyncImage(url: URL(string: imgurl)) { image in
                        image.resizable()
                    } placeholder: {
                        Image(systemName: "photo.circle.fill").resizable()
                    }
                    .clipShape(.circle) // make image a circle
                    .frame(width: 333, height: 333)
                    .padding(40)
                } else {
                    Text("NO IMAGE THUMB").foregroundStyle(.blue)
                }
                
                // Meal Name
                Text(meal.name ?? "")
                    .font(.title)

                // Ingredients / Measurements
                ForEach(meal.ingredients, id: \.self) { ingredient in
                    Text(ingredient.measure + " " + ingredient.name)
                }
                
                // Instructions
                Text(meal.instructions ?? "Instructions Unavailable")
                    .frame(width: 350)
            }
        }
    }
}

//#Preview {
//    DetailView()
//}
