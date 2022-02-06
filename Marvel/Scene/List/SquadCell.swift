import UIKit
import Combine

fileprivate let squadCellReuseIdentifier = "SquadCell"

class SquadCell: GenericTableViewCell {
    let titleLabel = UIComponent.shared.label(text: "My Squad", textColor: .white, font: .systemFont(ofSize: 14, weight: .bold))
    let squadCollectionView = UIComponent.shared.collectionview(lineSpacing: 5)
    @Published private(set) var selectedCharacter: CharacterViewModel?
    
    var squad : [CharacterViewModel]? {
        didSet {
            squadCollectionView.reloadData()
        }
    }
    override func setupUI() {
        contentView.addSubviews(views: titleLabel,squadCollectionView)
        squadCollectionView.delegate = self
        squadCollectionView.dataSource = self
        squadCollectionView.register(SquadItemCell.self, forCellWithReuseIdentifier: squadCellReuseIdentifier)
        setupConstraints()
    }
}


extension SquadCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.squad?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: squadCellReuseIdentifier, for: indexPath) as! SquadItemCell
        cell.nameLabel.text = squad?[indexPath.item].name
        let url = URL(string: squad![indexPath.item].imageUrl)
        cell.image.kf.setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCharacter = squad?[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 100)
    }
}

extension SquadCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //LABEL
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            
            //COLLECTION VIEW
            squadCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            squadCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 0),
            squadCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            squadCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            squadCollectionView.heightAnchor.constraint(equalToConstant: 135)
        ])
    }
}


