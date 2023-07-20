import SwiftUI

class CatBreedsListViewModel: ObservableObject {
    @Published var catBreeds: [CatBreed] = []
    @Published var images: [String:UIImage] = [:]
    private let apiKey = "ENTER YOUR API KEY"

    func fetchCatBreeds() {
        guard let breedsURL = URL(string: "https://api.thecatapi.com/v1/breeds/?page=1&limit=20") else {
            return
        }

        var request = URLRequest(url: breedsURL)
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")

        URLSession.shared.dataTask(with: breedsURL) { data, _, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            if let data = data {
                do {
                    let breeds = try JSONDecoder().decode([CatBreed].self, from: data)
                    DispatchQueue.main.async {
                        self.catBreeds = breeds
                    }
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}

