
struct Character: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
}

struct Thumbnail: Codable {
    let path: String
    let ext: String
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case ext = "extension"
    }
}
