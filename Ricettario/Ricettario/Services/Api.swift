import SwiftUI

class Api: ObservableObject {
    @Published var featuredRecipe: Recipe?

    let baseURL = "https://api.spoonacular.com/recipes"

    func loadRecipesData(completion: @escaping ([Recipe]) -> ()) {
        let urlString = "\(baseURL)/complexSearch?sort=popularity&sortDirection=desc&number=12&addRecipeInformation=true&apiKey=\(Secrets.spoonacularKey)"

        guard let url = URL(string: urlString) else {
            print("URL non valido")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Errore di rete")
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)

                DispatchQueue.main.async {
                    completion(decodedResponse.results)
                }
            } catch {
                print(error)
            }
        }.resume()
    }

    func loadRecipeDetail(id: Int, completion: @escaping (RecipeDetail) -> ()) {
        let urlString = "\(baseURL)/\(id)/information?apiKey=\(Secrets.spoonacularKey)"

        guard let url = URL(string: urlString) else {
            print("URL non valido")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Errore di rete")
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(RecipeDetail.self, from: data)

                DispatchQueue.main.async {
                    completion(decodedResponse)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
}

