import Foundation

extension Query {

    static let characterDetail =
    """
    query($id: ID!) {
      character(id: $id) {
        ...CharacterFragment
      }
    }
    """ + Character.fullFragment
}
