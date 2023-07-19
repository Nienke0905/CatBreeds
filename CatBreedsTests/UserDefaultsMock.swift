import Foundation

class UserDefaultsMock: UserDefaults {
    var storage: [String: Data] = [:]

    override func data(forKey defaultName: String) -> Data? {
        storage[defaultName]
    }

    override func set(_ value: Any?, forKey defaultName: String) {
        storage[defaultName] = value as? Data
    }
}
