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

    private func imageURL(for imageID: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "cdn2.thecatapi.com"
        components.path = "/images/\(imageID).jpg"
        return components.url
    }


    func loadImage(for imageID: String) {
        if let cachedImage = ImageCache.shared.get(forKey: imageID) {
            self.images[imageID] = cachedImage
            return
        }

        guard let url = imageURL(for: imageID) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self.images[imageID] = image
                    ImageCache.shared.set(image, forKey: imageID)
                } else {
                    if let defaultImage = UIImage(named: "cat") {
                        self.images[imageID] = defaultImage
                        ImageCache.shared.set(defaultImage, forKey: imageID)

                    }
                }
            }
        }
        task.resume()
    }

    func removeFavorite(forBreed breed: CatBreed) {
        favoritesManager.removeFavorite(breed)
        getFavorites()
    }
}
