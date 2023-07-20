import Foundation
import SwiftUI

class CatBreedRowViewModel: ObservableObject {
    @Published var breed: CatBreed
    @Published var image: UIImage?

    private let imageManager: ImageManagerProtocol

    init(
        breed: CatBreed,
        imageManager: ImageManagerProtocol = ImageManager.shared
    ) {
        self.breed = breed
        self.imageManager = imageManager
    }

    func loadImage() {
        guard let imageID = breed.referenceImageID else { return }
        imageManager.loadImage(forID: imageID) { [weak self] image in
            self?.image = image
        }
    }
}
