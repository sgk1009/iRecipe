//
//  ContentView.swift
//  iRecipe
//
//  Created by Sydney King on 8/12/24.
//

import SwiftUI

struct DessertView: View {
    @State private var desserts: [Desserts] = []
    @State private var filteredDesserts: [Desserts] = []
    @State private var currentID =  ""
    @State private var searchText = ""
    @State private var showRecipe = false
    
    
    var body: some View {
        NavigationStack {
            VStack{
                RecipeList(desserts: $filteredDesserts,currentID: $currentID, showRecipe: $showRecipe)
            }
            .navigationDestination(isPresented: $showRecipe){
                RecipeView(currentID: $currentID)
            }
            .navigationTitle("Recipes")
        }
        .searchable(text: $searchText)
        .onAppear {
            Task{
                do{
                    let result: MealResponse = try await APIManager.shared.fetchData(from: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")
                        desserts = result.meals
                        filterDesserts()
                } catch {
                    print("Error in fetching meals: \(error)")
                }
            }
        }
        .onChange(of: searchText){
            filterDesserts()
        }
    }
    
    
    func filterDesserts() {
        filteredDesserts = desserts.filter { dessert in
            searchText.isEmpty || dessert.strMeal.lowercased().contains(searchText.lowercased())
        }
    }
}

//struct view to list out all the recipes

struct RecipeList: View {
    //establish vars
    @Binding var desserts: [Desserts]
    @Binding var currentID: String
    @Binding var showRecipe: Bool
    
    
    var body: some View {
        List(desserts.sorted(by: {$0.strMeal < $1.strMeal}), id: \.idMeal){ dessert in
            Button{
                showRecipe.toggle()
                currentID = dessert.idMeal
            } label: {
                RecipeRow(dessert: dessert)
            }
        }
    }
}

//struct view for recipe in a row

struct RecipeRow: View {
    let dessert: Desserts
    
    var body: some View {
        HStack{
            Text(dessert.strMeal)
                .font(.title3)
                .foregroundStyle(.black)
            
            Spacer()
            
            AsyncImage(url: URL(string: dessert.strMealThumb)) { image in
                image.resizable()
                    .clipShape(Circle())
                    .overlay{
                        Circle().stroke(.white, lineWidth: 1)
                    }
                    .shadow(radius: 7)
            } placeholder: {
                ProgressView()
            }
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 100)
        }
    }
}



#Preview {
    DessertView()
}
