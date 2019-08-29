import Foundation

class CharacterService {

    static let shared = CharacterService()

    func fetchCharacterDetail(id: String) -> Single<Character> {
        let single: Single<RMResponse<CharacterDetailResponse>> =
            RMApi.shared.executeGraphQL(query: Query.characterDetail,
                                        variables: ["id": id])
        return single.map { (response) -> Character in
            return response.data.character
        }
    }
}
