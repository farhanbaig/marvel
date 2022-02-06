import Foundation
import Combine

protocol NetworkFetching {
    func load(_ request: URLRequest) -> AnyPublisher<Data,URLError>
}

extension URLSession: NetworkFetching {
    func load(_ request: URLRequest) ->  AnyPublisher<Data,URLError> {
        return dataTaskPublisher(for: request)
            .map {$0.data}
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
