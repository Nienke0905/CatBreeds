import Foundation
import SwiftUI

class CatBreedRowViewModel: ObservableObject {
    @Published var breed: CatBreed
    @Published var image: UIImage?

    init(breed: CatBreed) {
        self.breed = breed
    }

    private func imageURL(for imageID: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "cdn2.thecatapi.com"
        components.path = "/images/\(imageID).jpg"
        return components.url
    }


    func loadImage() {
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
}
