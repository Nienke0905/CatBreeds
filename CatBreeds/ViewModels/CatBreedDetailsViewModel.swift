import Foundation
import SwiftUI

class CatBreedDetailsViewModel: ObservableObject {
    @Published var breed: CatBreed
    @Published var image: UIImage?
    @Published var isFavorited: Bool = false

    private let favoritesManager: FavoritesManager

    init(breed: CatBreed) {
        self.breed = breed
        self.favoritesManager = FavoritesManager()
        self.isFavorited = favoritesManager.getFavorites().contains(where: { $0.id == breed.id })
        loadImage()
    }

    private func imageURL(for imageID: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "cdn2.thecatapi.com"
        components.path = "/images/\(imageID).jpg"
        return components.url
    }

    func loadIsFavorited() {
        isFavorited = favoritesManager.getFavorites().contains(where: { $0.id == breed.id })
    }

    private func loadImage() {
        guard let imageID = breed.referenceImageID else { return }
        if let cachedImage = ImageCache.shared.get(forKey: imageID) {
            self.image = cachedImage
            return
        }

        guard let url = imageURL(for: imageID) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self.image = image
                    ImageCache.shared.set(image, forKey: imageID)
                } else {
                    if let defaultImage = UIImage(named: "cat") {
                        self.image = defaultImage

                    }
                }
            }
        }
        task.resume()
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
