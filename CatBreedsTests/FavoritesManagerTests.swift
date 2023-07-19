import XCTest
@testable import CatBreeds

final class FavoritesManagerTests: XCTestCase {
    private var userDefaultsMock: UserDefaults!
    private var favoritesManager: FavoritesManager!

    private let catty = CatBreed(
        id: "abc",
        name: "Catty",
        temperament: "Affectionate, Dependent, Gentle, Intelligent, Playful",
        description: "Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee!Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee! Meow, meow, meeooow, memeoooow, meowee!Meow, meow, meeooow, memeoooow, meowee!",
        referenceImageID: "meowee"
    )

    override func setUpWithError() throws {
        try super.setUpWithError()
        userDefaultsMock = UserDefaultsMock()
        favoritesManager = FavoritesManager(userDefaults: userDefaultsMock)
    }

    override func tearDownWithError() throws {
        userDefaultsMock = nil
        favoritesManager = nil
    }


    func testGetFavoritesEmpty() {
        let favorites = favoritesManager.getFavorites()
        XCTAssertTrue(favorites.isEmpty, "Favorites should be empty when no favorites are saved.")
    }

    func testSaveFavorite() {
        favoritesManager.addFavorite(catty)

        let favorites = favoritesManager.getFavorites()
        XCTAssertEqual(favorites, [catty], "Saved favorites should match the breeds to save.")
    }

    func testRemoveFavorite() {
        favoritesManager.addFavorite(catty)
        favoritesManager.removeFavorite(catty)
        let favorites = favoritesManager.getFavorites()
        XCTAssertEqual(favorites, [], "Removed favorite should not be present in the favorites list.")
    }

}
