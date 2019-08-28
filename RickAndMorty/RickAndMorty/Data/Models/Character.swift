import Foundation

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown

    init(from decoder: Decoder) throws {
        self = try type(of: self).init(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }

}
struct Character: Codable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let image: String
}
