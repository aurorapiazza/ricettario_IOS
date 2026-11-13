import SwiftUI

struct Recipe: Codable, Identifiable {
    let id: Int
    let title: String
    let image: String?
    let readyInMinutes: Int?
}

struct RecipeResponse: Codable {
    let results: [Recipe]
    let totalResults: Int?
}

struct RandomRecipeResponse: Codable {
    let recipes: [Recipe]
}

struct RecipeDetail: Codable{
    let id: Int
    let title: String
    let image: String?
    let readyInMinutes: Int?
    let servings: Double?
    let extendedIngredients: [Ingredient]?
    
    struct Ingredient:Codable{
        let id: Int?
        let name: String
        let amount: Double
        let unit: String
        let measures: Measures?
    }
    
    struct Measures:Codable{
        let metric: Measure
    }
    
    struct Measure: Codable{
        let amount: Double
        let unitShort: String
    }

}


struct AnalyzedInstruction: Codable {
    let name: String
    let steps: [RecipeStep]
}

struct RecipeStep: Codable {
    let number: Int
    let step: String
    let ingredients: [RecipeIngredient]
    let length: StepLength?
}

struct RecipeIngredient: Codable {
    let id: Int
    let name: String
}

struct StepLength: Codable {
    let number: Int
    let unit: String
}
