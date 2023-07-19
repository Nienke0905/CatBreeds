import Foundation

class FavoritesManager {
    private let userDefaultsKey = "FavoriteItems"

    func getFavorites() -> [CatBreed] {
        guard let data = UserDefaults.standard.data(forKey: userDefaultsKey),
              let savedItems = try? JSONDecoder().decode([CatBreed].self, from: data) else {
            return []
        }
        return savedItems
    }

    func addFavorite(_ breed: CatBreed) {
        var favorites = getFavorites()
        favorites.append(breed)
        saveFavorites(favorites)
    }

    func removeFavorite(_ breed: CatBreed) {
        var favorites = getFavorites()
        favorites.removeAll { $0.id == breed.id }
        saveFavorites(favorites)
    }

    func saveFavorites(_ breeds: [CatBreed]) {
        if let encodedData = try? JSONEncoder().encode(breeds) {
            UserDefaults.standard.set(encodedData, forKey: userDefaultsKey)
        }
    }
}
