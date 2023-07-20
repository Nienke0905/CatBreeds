import Foundation

protocol FavoritesManagerProtocol {
    func getFavorites() -> [CatBreed]
    func addFavorite(_ breed: CatBreed)
    func removeFavorite(_ breed: CatBreed)
}

class FavoritesManager: FavoritesManagerProtocol {
    private let userDefaultsKey = "FavoriteItems"
    private let userDefaults: UserDefaults

    static let shared = FavoritesManager()

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }

    func getFavorites() -> [CatBreed] {
        guard let data = userDefaults.data(forKey: userDefaultsKey),
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

    private func saveFavorites(_ breeds: [CatBreed]) {
        if let encodedData = try? JSONEncoder().encode(breeds) {
            userDefaults.set(encodedData, forKey: userDefaultsKey)
        }
    }
}
