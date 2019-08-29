import Foundation

struct EpisodesResponse: Codable {
    let episodes: Episodes
}

struct Episodes: Codable {
    let results: [Episode]
}

struct EpisodeDetailResponse: Codable {
    let episode: Episode
}

struct Episode: Codable {
    let id: String
    let name: String
    let air_date: String
    let episode: String
    let characters: [Character]?

    static let listFragment =
    """
    fragment EpisodeFragment on Episode {
        id
        name
        air_date
        episode
    }
    """

    static let detailFragment =
    """
    fragment EpisodeFragment on Episode {
        id
        name
        air_date
        episode
        characters {
            ...CharacterFragment
        }
    }
    """
}
