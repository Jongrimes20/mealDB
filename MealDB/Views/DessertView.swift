//
//  DessertView.swift
//  MealDB
//
//  Created by Jon Grimes on 8/6/24.
//

import SwiftUI

struct DessertView: View {
    // for procesing fetch request from json URL
    @State private var processing: Bool = false
    // desserts collectd
    @State private var desserts = [Meal]()
    
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
                            ForEach(desserts, id: \.id) { dessert in
                                NavigationLink(destination: {
                                    DetailView(meal: dessert)
                                }, label: {
                                    MealCard(meal: dessert)
                                })
                            }
                        }
                    }
                })
            }
        }
        .task { // Query from mealsDB
            processing = true
            let response: ApiResponse? = await fetchMeals(urlString: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
            if let meals = response?.meals {
                desserts = meals
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
    DessertView()
}
