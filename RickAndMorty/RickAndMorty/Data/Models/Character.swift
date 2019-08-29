import Foundation

struct CharacterDetailResponse: Codable {
    let character: Character
}

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown

    init(from decoder: Decoder) throws {
        self = try type(of: self).init(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown

    init(from decoder: Decoder) throws {
        self = try type(of: self).init(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}

struct Character: Codable {
    let id: String
    let name: String
    let status: CharacterStatus
    let image: String
    let species: String?
    let type: String?
    let gender: Gender?
    let episode: [Episode]?

    static let simpleFragment =
    """
    fragment CharacterFragment on Character {
      id
      name
      status
      image
    }
    """

    static let fullFragment =
    """
    fragment CharacterFragment on Character {
      id
      name
      status
      image
      species
      type
      gender
      episode {
        id
        name
        episode
        air_date
      }
    }
    """
}
