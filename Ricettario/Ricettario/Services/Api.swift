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

    func loadRandomRecipe() {
        let urlString = "\(baseURL)/random?number=1&apiKey=\(Secrets.spoonacularKey)"

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
                let decodedResponse = try JSONDecoder().decode(RandomRecipeResponse.self, from: data)

                DispatchQueue.main.async {
                    self.featuredRecipe = decodedResponse.recipes.first
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    func searchRecipes(testo: String, tipo: String, dieta: String, cucina: String, tempoMax: Int,
                       ordinamento: String, offset: Int, completion: @escaping (RecipeResponse?) -> ()) {
        var urlString = "\(baseURL)/complexSearch?number=12&offset=\(offset)&addRecipeInformation=true&apiKey=\(Secrets.spoonacularKey)"

        if testo != "" {
            urlString = urlString + "&query=\(testo)"
        }
        if tipo != "" {
            urlString = urlString + "&type=\(tipo)"
        }
        if dieta != "" {
            urlString = urlString + "&diet=\(dieta)"
        }
        if cucina != "" {
            urlString = urlString + "&cuisine=\(cucina)"
        }
        if tempoMax > 0 {
            urlString = urlString + "&maxReadyTime=\(tempoMax)"
        }

        if ordinamento == "time" {
            urlString = urlString + "&sort=time&sortDirection=asc"
        } else {
            urlString = urlString + "&sort=popularity&sortDirection=desc"
        }

        guard let url = URL(string: urlString) else {
            print("URL non valido")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Errore di rete")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)

                DispatchQueue.main.async {
                    completion(decodedResponse)
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}

