import XCTest
@testable import Marvel

class CharacterViewModelTests: XCTestCase {
    func testViewModelMapValues() {
        let character = Character(id: 1,name: "Spiderman",description: "",thumbnail: .init(path: "www.example.com/image1", ext: "jpg"))
        let viewModel = CharacterViewModel(character: character)
        XCTAssertEqual(viewModel.name,character.name)
        XCTAssertEqual(viewModel.biography, character.description)
        XCTAssertEqual(viewModel.imageUrl, "www.example.com/image1.jpg")
    }
}
