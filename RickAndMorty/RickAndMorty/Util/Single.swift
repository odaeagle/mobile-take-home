import Foundation

/* no third party allowed... fine, then i write my own : )
 this is just a cheap recreation of Rx's Single, and allow me to
 do things in the background and chain multiple singles together
 */

class Single<T> {
    let work: () throws -> T

    init(work: @escaping () throws -> T) {
        self.work = work
    }

    func subscribe(_ completion: @escaping (T?, Error?) -> Void) {
        DispatchQueue.global().async {
            do {
                let result = try self.work()
                DispatchQueue.main.async {
                    completion(result, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }

    func map<R>(_ mapper: @escaping (T) throws -> R) -> Single<R> {
        return Single<R>(work: { () -> R in
            let result = try self.work()
            return try mapper(result)
        })
    }
}
