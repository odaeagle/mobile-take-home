import Foundation

struct EpisodesResponse: Codable {
    let episodes: Episodes
}

struct Episodes: Codable {
    let results: [Episode]
}

struct Episode: Codable {
    let id: String
    let name: String
    let air_date: String
    let episode: String
    let characters: [Character]?
}
