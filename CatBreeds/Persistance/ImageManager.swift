import SwiftUI

protocol ImageManagerProtocol {
    func loadImage(forID imageID: String, completion: @escaping (UIImage?) -> Void)
    func set(_ image: UIImage, forKey key: String)
    func get(forKey key: String) -> UIImage?
}

class ImageManager: ImageManagerProtocol {
    static let shared = ImageManager()

    private let cache = NSCache<NSString, UIImage>()

    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }

    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }

    private func imageURL(for imageID: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "cdn2.thecatapi.com"
        components.path = "/images/\(imageID).jpg"
        return components.url
    }

    func loadImage(forID imageID: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = ImageManager.shared.get(forKey: imageID) {
            completion(cachedImage)
            return
        }

        guard let url = imageURL(for: imageID) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    ImageManager.shared.set(image, forKey: imageID)
                    completion(image)
                } else {
                    if let defaultImage = UIImage(named: "cat") {
                        completion(defaultImage)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
        task.resume()
    }
}

