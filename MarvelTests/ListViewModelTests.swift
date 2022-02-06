import XCTest
import Combine
@testable import Marvel

class ListViewModelTests: XCTestCase {
    var cancellables = Set<AnyCancellable>()
    
    func testListViewModelFetchSucess() throws {
        let viewModel = ListViewModel(characterfetcher: CharacterFetcherStab(returning: .success(.init(data: .init(results: [
            Character(id: 1, name: "Character One", description: "", thumbnail: .init(path: "", ext: ""))
        ])))), squadFetcher: SquadFetcherStab())
        let expectation = XCTestExpectation(description: "Characters loaded sucessfully")
        viewModel.fetch()
        viewModel.characters.sink { characters in
            XCTAssertEqual(characters.count, 1)
            expectation.fulfill()
        }
        .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testListViewModelFetchFailure() throws {
        let error = NSError(domain: "", code: 1, userInfo: nil)
        let viewModel = ListViewModel(characterfetcher: CharacterFetcherStab(returning: .failure(error)), squadFetcher: SquadFetcherStab())
        viewModel.fetch()
        let expectation = XCTestExpectation(description: "Error message will be passed")
        viewModel.$error.sink { message in
            XCTAssertNotNil(message)
            expectation.fulfill()
        }
        .store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testListViewModelLoadSquad() throws {
        let viewModel = ListViewModel(characterfetcher: CharacterFetcherStab(), squadFetcher: SquadFetcherStab(returning: [1]))
        viewModel.characters.value = [CharacterViewModel(character: .init(id: 1, name: "Character One", description: "", thumbnail: .init(path: "", ext: "")))]
        viewModel.loadSquad()
        viewModel.squad.sink { result in
            XCTAssertEqual(result.count, 1)
        }
        .store(in: &cancellables)
    }
}


//MARK: SQUAD FETHER STAB
class SquadFetcherStab: SquadFetcherUseCase {
    private let squadIds: [Int]
    init(returning squadIds: [Int] = []) {
        self.squadIds = squadIds
    }
    
    func getAllSquadCharacterIds() -> [Int] {
        return self.squadIds
    }
    
    func recruit(_by id: Int) {
        
    }
    
    func fire(_by id: Int) {
        
    }
    
    func isSquadMember(id: Int) -> Bool {
        return getAllSquadCharacterIds().contains(id)
    }
}

//MARK: CHARACTER FETHER STAB
class CharacterFetcherStab: CharacterFetcherUseCase {
    private let result: Result<Response,Error>
    init(returning result: Result<Response,Error> = .success(.init(data: .init(results: [])))) {
        self.result = result
    }
    func fetchCharacters() -> AnyPublisher<Response, Error> {
        return result.publisher
            .delay(for: 0.1,scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
