import Foundation
import SwiftUI

class FavoriteBreedsViewModel: ObservableObject {
    @Published var catBreeds: [CatBreed] = []
    @Published var images: [String:UIImage] = [:]
    private let favoritesManager: FavoritesManagerProtocol
    private let imageManager: ImageManager


    init(
        favoritesManager: FavoritesManagerProtocol = FavoritesManager.shared,
        imageManager: ImageManager = .shared
    ) {
        self.favoritesManager = favoritesManager
        self.imageManager = imageManager
        self.catBreeds = favoritesManager.getFavorites()
    }

    func getFavorites() {
        catBreeds = favoritesManager.getFavorites()
    }

    func loadImage(for imageID: String) {
        imageManager.loadImage(forID: imageID) { [weak self] image in
            self?.images[imageID] = image
        }
    }

    func removeFavorite(forBreed breed: CatBreed) {
        favoritesManager.removeFavorite(breed)
        getFavorites()
    }
}
