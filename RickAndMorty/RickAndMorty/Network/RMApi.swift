import UIKit

class RMApi {

    static let shared = RMApi()

    func executeGraphQL<T: Codable>(query: String, variables: [String: Any]?) -> Single<T> {
        return Single<URLRequest>(work: { () -> URLRequest in
            var request = self.createRequest()
            let body = ["query": query, "variables": variables ?? [:]] as [String : Any]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            return request
        }).map({ (request) -> Data in
            return try self.executeRequest(request: request)
        }).map({ (data) -> T in
            let parsed = try JSONDecoder().decode(T.self, from: data)
            return parsed
        })
    }

    func downloadImage(url: String) -> Single<UIImage> {
        return Single<URLRequest>(work: { () -> URLRequest in
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "GET"
            return request
        }).map({ (request) -> Data in
            return try self.executeRequest(request: request)
        }).map({ (data) -> UIImage in
            return UIImage(data: data)!
        })
    }

    private func createRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: "https://rickandmortyapi.com/graphql")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }

    private func executeRequest(request: URLRequest) throws -> Data {
        /* been a while i use low level request functions lol */
        
        let session = URLSession.shared
        var dataReceived: Data?
        var receivedError: Error?
        let sem = DispatchSemaphore.init(value: 0)

        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                receivedError = error
            } else {
                dataReceived = data
            }
            sem.signal()
        }

        task.resume()
        sem.wait()

        if dataReceived != nil {
            return dataReceived!
        } else {
            throw receivedError!
        }
    }
}
