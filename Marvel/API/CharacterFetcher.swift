import Combine
import Foundation

protocol CharacterFetcherUseCase {
    func fetchCharacters() -> AnyPublisher<Response,Error>
}

class CharacterFetcher: CharacterFetcherUseCase {
    let networkFetching: NetworkFetching
    init(networkFetching: NetworkFetching = URLSession.shared) {
        self.networkFetching = networkFetching
    }
    
    func fetchCharacters() -> AnyPublisher<Response, Error> {
        let url = URL.getCharacterURL()
        let request = URLRequest(url: url)
        return networkFetching.load(request)
            .decode(type: Response.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


