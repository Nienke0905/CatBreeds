import Foundation
import SwiftUI

class CatBreedDetailsViewModel: ObservableObject {
    @Published var breed: CatBreed
    @Published var image: UIImage?
    @Published var isFavorited: Bool = false

    private let favoritesManager: FavoritesManager
    private let imageManager: ImageManagerProtocol


    init(
        breed: CatBreed,
        favoritesManager: FavoritesManager = .shared,
        imageManager: ImageManagerProtocol = ImageManager.shared
    ) {
        self.breed = breed
        self.favoritesManager = favoritesManager
        self.imageManager = imageManager
        self.isFavorited = favoritesManager.getFavorites().contains(where: { $0.id == breed.id })
        loadImage()
    }

    func loadIsFavorited() {
        isFavorited = favoritesManager.getFavorites().contains(where: { $0.id == breed.id })
    }

    private func loadImage() {
        guard let imageID = breed.referenceImageID else { return }
        imageManager.loadImage(forID: imageID) { [weak self] image in
            self?.image = image
        }
    }

    func toggleIsFavorited() {
        if isFavorited {
            favoritesManager.removeFavorite(breed)
        } else {
            favoritesManager.addFavorite(breed)
        }
        isFavorited = favoritesManager.getFavorites().contains(where: { $0.id == breed.id })
    }
}
