import UIKit

class SquadItemCell: UICollectionViewCell {
    var image = UIComponent.shared.imageView(name: "")
    var nameLabel = UIComponent.shared.label(text: "", textColor: .white, font: UIFont.systemFont(ofSize: 13, weight: .semibold),alignment: .center)
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        image.layer.cornerRadius = 40
        addSubviews(views: image,nameLabel)
        setupConstraints()
    }
}

extension SquadItemCell {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.widthAnchor.constraint(equalToConstant: 80),
            image.heightAnchor.constraint(equalToConstant: 80),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: image.bottomAnchor,constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: image.centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant:  10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -10)
        ])
    }
}

