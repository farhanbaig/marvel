import Foundation

extension URL {
    static func getCharacterURL() -> URL {
        let urlComponents = NSURLComponents(string: "http://gateway.marvel.com/v1/public/characters")!
        urlComponents.queryItems = [
        URLQueryItem(name: "ts", value: "\(Constants.ts)"),
        URLQueryItem(name: "apikey", value: Constants.Keys.publicKey),
        URLQueryItem(name: "hash", value: Constants.hash),
        ]
        return urlComponents.url!
    }
}
