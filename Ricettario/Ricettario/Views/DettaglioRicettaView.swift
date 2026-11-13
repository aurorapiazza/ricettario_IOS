import SwiftUI

struct DettaglioRicettaView: View{
    var recipe: Recipe
    
    @StateObject private var api = Api()
    @State private var dettaglio: RecipeDetail?
    
    var ingredienti: [RecipeDetail.Ingredient]{
        return dettaglio?.extendedIngredients ?? []
    }
    
    func quantita(_ ingrediente: RecipeDetail.Ingredient) -> String{
        if let metrico = ingrediente.measures?.metric {
            return "\(metrico.amount.formatted()) \(metrico.unitShort)"
        }
        return "\(ingrediente.amount.formatted()) \(ingrediente.unit)"
    }
    
    var body: some View{
        ScrollView{
            VStack(alignment: .leading, spacing: 16){
                ZStack(alignment: .bottom){
                    AsyncImage(
                        url: URL(string: recipe.image ?? ""),
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }, placeholder: {
                            Color.gray.opacity(0.2)
                        })
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    
                    HStack{
                        Text("\(recipe.readyInMinutes ?? 0) min")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.white)
                            .overlay(Capsule().stroke(Color.gray, lineWidth: 1))
                        Spacer()
                    }
                    .padding(10)
                }
                
                HStack{
                    Text(recipe.title)
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    BottonePreferito(recipe:recipe, dimensione: 28)
                }
                
                if dettaglio == nil {
                    Text("Caricamento della riceta...")
                        .foregroundColor(.gray)
                }
                
                Text("Ingredienti")
                    .font(.title2)
                    .bold()
                
                ForEach(0..<ingredienti.count, id: \.self){ indice in
                    HStack{
                        Text(ingredienti[indice].name)
                        Spacer()
                        Text(quantita(ingredienti[indice]))
                            .foregroundColor(.gray)
                    }
                    Divider()
                }
            }
            .padding()
            
        }
        .onAppear(){
            if dettaglio == nil{
                api.loadRecipeDetail(id: recipe.id){
                    (ricetta) in
                    self.dettaglio = ricetta
                }
            }
        }
    }
}

