import Foundation
import SwiftUI

class CatBreedRowViewModel: ObservableObject {
    @Published var breed: CatBreed
    @Published var image: UIImage?

    init(breed: CatBreed) {
        self.breed = breed
    }

    func loadImage() {
        guard let imageID = breed.referenceImageID else { return }
        ImageManager.loadImage(forID: imageID) { [weak self] image in
            self?.image = image
        }
    }
}
