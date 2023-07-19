import Foundation

struct CatBreed: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    let temperament: String
    let description: String
    let referenceImageID: String?

    enum CodingKeys: String, CodingKey {
        case id, name, description, temperament
        case referenceImageID = "reference_image_id"
    }
}
