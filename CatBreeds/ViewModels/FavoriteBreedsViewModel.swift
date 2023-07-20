import Foundation
import SwiftUI

class FavoriteBreedsViewModel: ObservableObject {
    @Published var catBreeds: [CatBreed] = []
    @Published var images: [String:UIImage] = [:]
    private let apiKey = "live_43f7SULSRO8PjBZ587Gvmj3jgW3HNVyY1bxlcbtSETJKvTW41UXzSiod8FZTHwax"
    private let favoritesManager = FavoritesManager()

    init() {
        self.catBreeds = favoritesManager.getFavorites()
    }

    func getFavorites() {
        catBreeds = favoritesManager.getFavorites()
    }

    func loadImage(for imageID: String) {
        ImageManager.loadImage(forID: imageID) { [weak self] image in
            self?.images[imageID] = image
        }
    }

    func removeFavorite(forBreed breed: CatBreed) {
        favoritesManager.removeFavorite(breed)
        getFavorites()
    }
}
