import XCTest
@testable import CatBreeds

final class FavoriteBreedsViewModelTests: XCTestCase {
    private var favoritesManagerMock: FavoritesManagerMock!
    private var imageManagerMock: ImageManagerMock!
    private var viewModel: FavoriteBreedsViewModel!

    private let catty = CatBreed(
        id: "abc",
        name: "Catty",
        temperament: "Affectionate, Dependent, Gentle, Intelligent, Playful",
        description: "Meow, meow",
        referenceImageID: "meowee"
    )

    override func setUpWithError() throws {
        try super.setUpWithError()
        favoritesManagerMock = FavoritesManagerMock()
        imageManagerMock = ImageManagerMock()
        viewModel = FavoriteBreedsViewModel(favoritesManager: favoritesManagerMock, imageManager: imageManagerMock)
    }

    override func tearDownWithError() throws {
        viewModel = nil
        favoritesManagerMock = nil
        imageManagerMock = nil
        try super.tearDownWithError()
    }

    func testGetFavorites() throws {
        favoritesManagerMock.favorites = [catty]
        viewModel.getFavorites()
        let favorites = viewModel.catBreeds
        XCTAssertEqual(favorites, [catty], "Favorites should match the breeds saved.")
    }

    func testAddFavorite() throws {
        favoritesManagerMock.favorites = [catty]
        viewModel.removeFavorite(forBreed: catty)
        let favorites = viewModel.catBreeds
        XCTAssertEqual(favorites, [], "Favorites should match the breeds saved after removal.")
    }

    func testLoadImage() throws {
        imageManagerMock.shouldSucceed = true
        viewModel.loadImage(for: catty.referenceImageID!)
        let image = viewModel.images[catty.referenceImageID!]
        XCTAssertEqual(image, UIImage(named: "cat"))
    }

    func testLoadImageWithNoResult() throws {
        imageManagerMock.shouldSucceed = false
        viewModel.loadImage(for: catty.referenceImageID!)
        let image = viewModel.images[catty.referenceImageID!]
        XCTAssertNil(image)
    }
}
