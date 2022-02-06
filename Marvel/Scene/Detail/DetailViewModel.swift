import Combine

class DetailViewModel {
    let character: CharacterViewModel
    @Published var isSquadMember: Bool
    private let squadService: SquadFetcherUseCase
    
    init(squadService: SquadFetcherUseCase, character: CharacterViewModel) {
        self.squadService = squadService
        self.character = character
        self.isSquadMember = squadService.isSquadMember(id: character.id)
    }
    
    func recruit() {
        squadService.recruit(_by: character.id)
        isSquadMember = true
    }
    
    func fire() {
        squadService.fire(_by: character.id)
        isSquadMember = false
    }
}
