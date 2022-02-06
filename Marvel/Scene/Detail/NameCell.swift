import UIKit

class NameCell: GenericTableViewCell {
    var nameLabel = UIComponent.shared.label(text: "", textColor: .white, font: UIFont.systemFont(ofSize: 22, weight: .bold))
    override func setupUI() {
        addSubviews(views: nameLabel)
        setupConstraints()
    }
}

extension NameCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            nameLabel.topAnchor.constraint(equalTo: topAnchor,constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -16)
        ])
    }
}

