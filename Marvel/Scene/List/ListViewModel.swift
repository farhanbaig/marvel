import Combine

class ListViewModel: ObservableObject {
    var cancellables = Set<AnyCancellable>()
    var characters = CurrentValueSubject<[CharacterViewModel],Never>([CharacterViewModel]())
    var squad = CurrentValueSubject<[CharacterViewModel],Never>([CharacterViewModel]())
    @Published private(set) var error: String?
    
    private let characterFetcher : CharacterFetcherUseCase
    private let squadFetcher: SquadFetcherUseCase
    
    init(characterfetcher: CharacterFetcherUseCase, squadFetcher: SquadFetcherUseCase) {
        self.characterFetcher = characterfetcher
        self.squadFetcher = squadFetcher
    }
    
    func fetch() {
        characterFetcher.fetchCharacters()
            .sink(receiveCompletion: {completion in
                guard case .failure(let error) = completion else {return}
                self.error = error.localizedDescription
            }, receiveValue: { [weak self] response in
                self?.characters.value = response.data.results.map({CharacterViewModel(character: $0)}).sorted {$0.name < $1.name}
                //check for squad...
                self?.loadSquad()
            })
            .store(in: &cancellables)
    }
    
    func loadSquad() {
        self.squad.value = self.characters.value.filter({squadFetcher.getAllSquadCharacterIds().contains($0.id)})
    }
}
