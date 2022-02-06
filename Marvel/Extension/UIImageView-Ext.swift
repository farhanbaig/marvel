import UIKit

extension UIImageView {
    func setImage(imageURL: String) {
        let url = URL(string: imageURL)
        let placeholderImage = UIImage(named: "")
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url,placeholder: placeholderImage)
    }
}
