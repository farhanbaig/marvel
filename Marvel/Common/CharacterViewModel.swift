
struct CharacterViewModel {
    let id: Int
    let name: String
    let imageUrl: String
    let biography: String
    
    init(character: Character) {
        self.id = character.id
        self.name = character.name
        self.imageUrl = character.thumbnail.path + "." + character.thumbnail.ext
        self.biography = character.description 
    }
}
