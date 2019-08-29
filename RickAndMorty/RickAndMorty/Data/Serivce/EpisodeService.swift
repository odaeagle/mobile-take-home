import Foundation

class EpisodeService {

    static let shared = EpisodeService()

    func fetchEpisodeList() -> Single<[Episode]> {
        let single: Single<RMResponse<EpisodesResponse>> =
            RMApi.shared.executeGraphQL(query: Query.episodeList,
                                        variables: nil)
        return single.map({ (response) -> [Episode] in
            return response.data.episodes.results
        })
    }

    func fetchEpisodeDetail(id: String) -> Single<Episode> {
        let single: Single<RMResponse<EpisodeDetailResponse>> =
        RMApi.shared.executeGraphQL(query: Query.episodeDetail,
                                    variables: ["id": id])
        return single.map { (response) -> Episode in
            return response.data.episode
        }
    }
}
