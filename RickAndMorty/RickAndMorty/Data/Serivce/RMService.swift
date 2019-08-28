/* Usually i break service into multiple files depending on
   business logic, since we only gonna have couples of apis here
   just throw them all into one file then */

import Foundation

let query =
"""
{
    episodes {
        info {
            count
            pages
            next
            prev
        }
        results {
            id
            name
            air_date
            episode
        }
    }
}
"""

class RMService {
    
    static let shared = RMService()

    func fetchEpisodeList() -> Single<RMResponse<EpisodesResponse>> {
        return RMApi.shared.executeGraphQL(query: query,
                                           parameters: nil)
    }
}
