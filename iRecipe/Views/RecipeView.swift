//
//  RecipeView.swift
//  iRecipe
//
//  Created by Sydney King on 8/13/24.
//

import SwiftUI

struct RecipeView: View {
    
    @State var dessertRecipe: [DessertRecipe] = []
    @Binding var currentID: String
    
    var body: some View {
        ScrollView {
            ForEach(dessertRecipe, id: \.idMeal) { recipe in
                AsyncImage(url: URL(string: recipe.strMealThumb)) { image in
                    image.resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 4, style: .continuous))
                        .shadow(radius: 7)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 370, height: 270)
                VStack(alignment: .leading, spacing: 10){
                    
                    Text(recipe.strMeal)
                        .foregroundStyle(.black)
                        .font(.title)
                        .bold()
                        
                                                
                    HStack{
                        IngredientsView(currentID: $currentID)
                    }
                    
                    //ingredients before instructions
                    Spacer()
                    Text("Instructions:")
                        .font(.headline)
                    Text(recipe.strInstructions)
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    
                }
                .padding(.horizontal, 20)
                
            }
        }
        .onAppear{
            Task{
                do {
                    let result: RecipeResponse = try await APIManager.shared.fetchData(from: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(currentID)")
                    dessertRecipe = result.meals
                } catch {
                    if currentID.isEmpty {
                        print("ID not valid")
                    } else{
                        print("Error in fetching recipe: \(error)")
                    }
                }
            }
        }
    }
}

#Preview {
    RecipeView(currentID: .constant("53049"))
}

