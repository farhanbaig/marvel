import UIKit

class BiographyCell: GenericTableViewCell {
    var biographyLabel = UIComponent.shared.label(text: "", textColor: .white, font: .systemFont(ofSize: 14))
    override func setupUI() {
        addSubviews(views: biographyLabel)
        setupConstraints()
    }
}

extension BiographyCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            biographyLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            biographyLabel.topAnchor.constraint(equalTo: topAnchor,constant: 16),
            biographyLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            biographyLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16)
        ])
    }
}

