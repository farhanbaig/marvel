import XCTest
import Combine
@testable import Marvel

class CharacterFetcherTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    func testOnRequestSuccessPublishedDecodedResponse() throws {
        let json = """
        {
        "data" : {
        "results" : [
           {
            "id": 1,
            "name": "Character One",
            "description": "Character one description.",
            "thumbnail": {
             "path": "",
            "extension": ""
        }
           }
        ]
        }
        }
        """
        let data = try XCTUnwrap(json.data(using: .utf8))
        let characterFetcher = CharacterFetcher(networkFetching: NetworkFetchingStab(returning: .success(data)))
        let expectation = XCTestExpectation(description: "Publishes decoded Response")
        characterFetcher.fetchCharacters()
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else {return}
                XCTFail("Expected to succeed but failed with" + error.localizedDescription)
                expectation.fulfill()
            }, receiveValue: {response in
                XCTAssertEqual(response.data.results.count, 1)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testOnRequestFailurePublishesRecievedError() {
        let expectedError = URLError(.badServerResponse)
        let characterFetcher = CharacterFetcher(networkFetching: NetworkFetchingStab(returning: .failure(expectedError)))
        let expectation = XCTestExpectation(description: "Publishes received error")
        characterFetcher.fetchCharacters()
            .sink(receiveCompletion: { completion in
                guard case .failure(let error) = completion else {return}
                XCTAssertEqual(error as? URLError, expectedError)
                expectation.fulfill()
            }, receiveValue: {response in
                XCTFail("Expected to fail")
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 0.1)
    }
}


class NetworkFetchingStab: NetworkFetching {
    private let result: Result<Data,URLError>
    init(returning result: Result<Data,URLError>) {
        self.result = result
    }
    func load(_ request: URLRequest) -> AnyPublisher<Data, URLError> {
        return result.publisher
            .delay(for: 0.01,scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
