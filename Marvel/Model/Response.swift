import Foundation
struct Response: Decodable {
    let data: ResultData
}


struct ResultData: Decodable {
    let results: [Character]
}
