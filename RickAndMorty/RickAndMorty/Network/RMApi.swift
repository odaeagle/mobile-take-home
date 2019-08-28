import Foundation

class RMApi {
    static let shared = RMApi()

    func executeGraphQL<T: Codable>(query: String, parameters: [String: Any]?) -> Single<T> {
        return Single<URLRequest>(work: { () -> URLRequest in
            var request = self.createRequest()
            let body = ["query": query, "parameters": parameters ?? [:]] as [String : Any]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            return request
        }).map({ (request) -> Data in
            return try self.executeRequest(request: request)
        }).map({ (data) -> T in
            let parsed = try JSONDecoder().decode(T.self, from: data)
            return parsed
        })
    }

    private func createRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: "https://rickandmortyapi.com/graphql")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }

    private func executeRequest(request: URLRequest) throws -> Data {
        let session = URLSession.shared
        var dataReceived: Data?
        var receivedError: Error?
        print(Thread.current)
        let sem = DispatchSemaphore.init(value: 0)

        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                receivedError = error
            } else {
                dataReceived = data
                print(String(data: dataReceived!, encoding: .utf8))
            }
            print("XXX", response)
            sem.signal()
        }

        task.resume()

        // This line will wait until the semaphore has been signaled
        // which will be once the data task has completed
        sem.wait()

        if dataReceived != nil {
            return dataReceived!
        } else {
            throw receivedError!
        }
    }
}
