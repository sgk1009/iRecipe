//
//  Meals.swift
//  iRecipe
//
//  Created by Sydney King on 8/12/24.
//

import Foundation

//base dessert meal from endpoint: https://themealdb.com/api/json/v1/1/filter.php?c=Dessert

struct MealResponse: Codable{
    let meals: [Desserts]
}

struct Desserts: Codable{
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}



