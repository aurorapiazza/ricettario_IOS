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

