import UIKit

class ActionCell: GenericTableViewCell {
    let button = UIComponent.shared.button(title: "", titleColor: .white, bgColor: .red, font: .systemFont(ofSize: 13, weight: .bold))
    
    var isSquadMember: Bool? {
        didSet  {
            guard let isSquadMember = self.isSquadMember else {return}
            if isSquadMember {
                setAsFireAction()
            }
            else {
                setAsRecruitAction()
            }
        }
    }
    
    override func setupUI() {
        contentView.addSubviews(views: button)
        setupConstraints()
    }
}

extension ActionCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 16),
            button.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 16),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -16),
            button.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}

extension ActionCell {
    private func setAsRecruitAction() {
        button.backgroundColor = .red
        button.layer.borderWidth = 0
        button.setTitle("💪 Recruit to Squad", for: .normal)
    }
    
    private func setAsFireAction() {
        button.layer.borderWidth = 1
        button.backgroundColor = .clear
        button.layer.borderColor =  UIColor.red.cgColor
        button.setTitle("🔥 Fire from Squad", for: .normal)
    }
}
