import UIKit

class UIComponent {
    private init() {}
    static let shared = UIComponent()
}

//MARK: LABEL
extension UIComponent {
    func label(text: String,textColor: UIColor,font: UIFont, numberOfLines: Int = 0, alignment: NSTextAlignment = .left) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = font
        label.numberOfLines = numberOfLines
        label.textAlignment = alignment
        return label
    }
}

//MARK: IMAGE VIEW
extension UIComponent {
    func imageView(name: String, contentMode: UIView.ContentMode = .scaleAspectFill, clipsToBounds: Bool = true) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: name)
        imageView.contentMode = contentMode
        imageView.clipsToBounds = clipsToBounds
        return imageView
    }
}

//MARK: BUTTON
extension UIComponent {
    func button(title: String,titleColor: UIColor,bgColor: UIColor, font: UIFont) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = bgColor
        button.setTitleColor(titleColor, for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = font
        return button
    }
}


//MARK: UICOLLECTIONVIEW
extension UIComponent {
    func collectionview(lineSpacing : CGFloat = 2, itemSpacing : CGFloat = 0,scrollDirection : UICollectionView.ScrollDirection = .horizontal ) -> UICollectionView {
        let cv : UICollectionView = {
            let flowLayout: UICollectionViewFlowLayout = {
                let layout = UICollectionViewFlowLayout()
                layout.minimumLineSpacing = lineSpacing
                layout.minimumInteritemSpacing = itemSpacing
                layout.scrollDirection = scrollDirection
                layout.sectionHeadersPinToVisibleBounds = false
                return layout
            }()
            return UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        }()
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        return cv
    }
}

