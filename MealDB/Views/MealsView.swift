//
//  MealsView.swift
//  MealDB
//
//  Created by Jon Grimes on 8/9/24.
//

import SwiftUI

struct MealsView: View {
    // for procesing fetch request from json URL
    @State private var processing: Bool = false
    // desserts collectd
    @State private var meals = [Meal]()
    
    var body: some View {
        NavigationStack {
            VStack {
                // Add a logo here
                
                ScrollView(.horizontal, content: {
                    HStack {
                        if processing {
                            ProgressView("Loading Desserts...")
                        }
                        else {
                            ForEach(meals, id: \.id) { meal in
                                NavigationLink(destination: {
                                    DetailView(meal: meal)
                                }, label: {
                                    MealCard(meal: meal)
                                })
                            }
                        }
                    }
                })
            }
        }
        .task { // Query from mealsDB
            processing = true
            // this url contains null but was this link provided in the project document
            // https://themealdb.com/api/json/v1/1/lookup.php?i=MEAL_ID
            // this link has info and retrievs meals by ID
            // https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772
            let response: ApiResponse? = await fetchMeals(urlString: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772")
            if let mealsResponse = response?.meals {
                meals = mealsResponse
            }
            processing = false
        }
    }
    
    // Fetch Meals Func
    func fetchMeals<T: Decodable>(urlString: String) async -> T? {
        // desserts
        let url = URL(string: urlString)!
        
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print(URLError(.badServerResponse))
                return nil
            }
            return try JSONDecoder().decode(T.self, from: data)
        }
        catch {
            print("----> error: \(error)")
            return nil
        }
    }
}

#Preview {
    MealsView()
}
