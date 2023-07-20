@testable import CatBreeds
import Foundation

class FavoritesManagerMock: FavoritesManagerProtocol {
    var favorites: [CatBreed] = []

    func getFavorites() -> [CatBreed] {
        return favorites
    }

    func addFavorite(_ breed: CatBreed) {
        favorites.append(breed)
    }

    func removeFavorite(_ breed: CatBreed) {
        favorites.removeAll { $0.id == breed.id }
    }
}
