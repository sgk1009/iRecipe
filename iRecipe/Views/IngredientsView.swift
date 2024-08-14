//
//  IngredientsView.swift
//  iRecipe
//
//  Created by Sydney King on 8/13/24.
//

import SwiftUI

struct IngredientsView: View {
    @State private var dessertRecipe: DessertRecipe?
    @Binding var currentID: String
    
    var body: some View {
        VStack{
            if let dessertRecipe = dessertRecipe {
                HStack{
                    Text("Ingredients:")
                        .fontWeight(.bold)
                    Spacer()
                    Text("Measurements:")
                        .fontWeight(.bold)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 10)
                
                ForEach(1...20, id: \.self) { index in
                    if let (ingredient,measurement) = dessertRecipe.value(forIndex: index) {
                        if !ingredient.isEmpty && !measurement.isEmpty {
                            HStack{
                                Text(ingredient)
                                Spacer()
                                Text(measurement)
                            }
                            .padding(.horizontal, 30)
                            Divider()
                        }
                    }
                }
            }
            else{
                ProgressView()
            }
        }
        .onAppear{
            Task{
                do{
                    let result: RecipeResponse = try await APIManager.shared.fetchData(from: "https://themealdb.com/api/json/v1/1/lookup.php?i=53049")
                    dessertRecipe = result.meals.first
                } catch {
                    if currentID.isEmpty {
                        print("ID is invalid")
                    }
                    else{
                        print("Error fetching recipe: \(error)")
                    }
                }
            }
        }
    }
}

extension DessertRecipe {
    
    func value(forIndex index:Int) -> (String,String)? {
        switch index{
            case 1: return (strIngredient1, strMeasure1)
            case 2: return (strIngredient2, strMeasure2)
            case 3: return (strIngredient3, strMeasure3)
            case 4: return (strIngredient4, strMeasure4)
            case 5: return (strIngredient5, strMeasure5)
            case 6: return (strIngredient6, strMeasure6)
            case 7: return (strIngredient7, strMeasure7)
            case 8: return (strIngredient8, strMeasure8)
            case 9: return (strIngredient9, strMeasure9)
            case 10: return (strIngredient10, strMeasure10)
            case 11: return (strIngredient11, strMeasure11)
            case 12: return (strIngredient12, strMeasure12)
            case 13: return (strIngredient13, strMeasure13)
            case 14: return (strIngredient14, strMeasure14)
            case 15: return (strIngredient15, strMeasure15)
            case 16: return (strIngredient16, strMeasure16)
            case 17: return (strIngredient17, strMeasure17)
            case 18: return (strIngredient18, strMeasure18)
            case 19: return (strIngredient19, strMeasure19)
            case 20: return (strIngredient20, strMeasure20)
        default:
            return nil
        }
    }
}

#Preview {
    IngredientsView(currentID: .constant("53049"))
}
