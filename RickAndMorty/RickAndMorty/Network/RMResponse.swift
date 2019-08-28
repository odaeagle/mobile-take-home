import Foundation

struct RMResponse<T: Codable>: Codable {
    let data: T
}
