import UIKit
import Kingfisher

//MARK: LIST ROW CELL
class ListRowCell: GenericTableViewCell {
    let container = UIView()
    let image = UIComponent.shared.imageView(name: "", contentMode: .scaleAspectFill)
    let nameLabel = UIComponent.shared.label(text: "", textColor: .white, font: UIFont.systemFont(ofSize: 15, weight: .bold))
    let accessory = UIComponent.shared.imageView(name: "", contentMode: .scaleAspectFit)
    
    var character: CharacterViewModel? {
        didSet {
            guard let character = self.character else {return}
            self.nameLabel.text = character.name
            self.image.setImage(imageURL: character.imageUrl)
        }
    }
    
    override func setupUI() {
        image.layer.cornerRadius = 25
        container.backgroundColor = .lightBackground
        container.layer.cornerRadius = 10
        container.addSubviews(views: image,nameLabel,accessory)
        accessory.image = UIImage(systemName: "chevron.right")
        accessory.contentMode = .scaleAspectFit
        accessory.tintColor = .lightText
        addSubviews(views: container)
        setupConstraints()
    }
}

extension ListRowCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //Container
            container.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 16),
            container.topAnchor.constraint(equalTo: topAnchor,constant: 16),
            container.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -16),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            //Image
            image.leadingAnchor.constraint(equalTo: container.leadingAnchor,constant: 16),
            image.topAnchor.constraint(equalTo: container.topAnchor,constant: 16),
            image.bottomAnchor.constraint(equalTo: container.bottomAnchor,constant: -16),
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 50),
            //Label
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor,constant: 20),
            nameLabel.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: accessory.leadingAnchor,constant: -16),
            //Accessory
            accessory.centerYAnchor.constraint(equalTo: image.centerYAnchor),
            accessory.widthAnchor.constraint(equalToConstant: 20),
            accessory.heightAnchor.constraint(equalToConstant: 20),
            accessory.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16)
        ])
    }
}

