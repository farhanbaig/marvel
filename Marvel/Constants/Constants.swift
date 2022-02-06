
struct Constants {
     struct Keys {
        static let publicKey =  "90beefe1964ec3b067d2940a8cc55389"
        static let privateKey =  "0a54be466c5ca667cd00c76491041288b6d666c9"
    }
    static var hash: String {
        let combined = "\(Constants.ts)" + Constants.Keys.privateKey + Constants.Keys.publicKey
        let md5Data = MD5Generator().MD5(string: combined)
        let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
        return md5Hex
    }
    static let ts = 1
}
