import Foundation

extension Query {
    
    static let episodeList =
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
                ...EpisodeFragment
            }
        }
    }
    """ + Episode.listFragment

    static let episodeDetail =
    """
    query($id: ID!) {
      episode(id: $id) {
        ...EpisodeFragment
      }
    }
    """ + Episode.detailFragment
        + Character.simpleFragment
}
