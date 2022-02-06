import UIKit

class ImageCell: GenericTableViewCell {
    let image = UIComponent.shared.imageView(name: "", contentMode: .scaleAspectFill, clipsToBounds: true)
    override func setupUI() {
        addSubviews(views: image)
        setupConstraints()
    }
}
extension ImageCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.topAnchor.constraint(equalTo: topAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
}

