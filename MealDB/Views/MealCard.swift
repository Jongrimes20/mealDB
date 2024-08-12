//
//  DetailView.swift
//  MealDB
//
//  Created by Jon Grimes on 8/9/24.
//

import SwiftUI

struct MealCard: View {
    var meal: Meal
    
    var body: some View {
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
                .overlay { // border
                    Circle()
                        .stroke(.blue, lineWidth: 20)
                        .shadow(color: .black, radius: 15.0, x: 5.0, y: 10.0)
                }
                
                .padding(40)
            } else {
                Text("NO IMAGE THUMB").foregroundStyle(.blue)
            }
            
            // Text
            // Add custom font
            Text(meal.name ?? "")
                .font(.custom("Oswald-Regular", size: 25))
        }
    }
    
}


