@testable import CatBreeds
import SwiftUI

class ImageManagerMock: ImageManagerProtocol {
    var shouldSucceed: Bool = true
    var cache: [String:UIImage] = [:]

    func loadImage(forID imageID: String, completion: @escaping (UIImage?) -> Void) {
        if shouldSucceed {
            let image = UIImage(named: "cat")
            completion(image)
        } else {
            completion(nil)
        }
    }

    func set(_ image: UIImage, forKey key: String) {
        cache[key] = image
    }

    func get(forKey key: String) -> UIImage? {
        cache[key]
    }
}
