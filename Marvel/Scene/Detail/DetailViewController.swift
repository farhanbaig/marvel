import UIKit
import Combine

//MARK: ROWS
fileprivate enum Row {
    case image
    case name
    case action
    case biography
}

class DetailViewController: UITableViewController {
    var cancellables =  Set<AnyCancellable>()
    var viewModel : DetailViewModel!
    @Published var updateSquadList: Bool = false
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let rows: [Row] = [.image,.name,.action,.biography]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .darkBackground
        bindingViewModel()
    }
}

//MARK: TABLE VIEW DATA SOURCE AND DELEGATE
extension DetailViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch rows [indexPath.row] {
        case .image:
            let cell = ImageCell()
            cell.image.setImage(imageURL: viewModel.character.imageUrl)
            return cell
        case .name:
            let cell = NameCell()
            cell.nameLabel.text = viewModel.character.name
            return cell
        case .action:
            let cell = ActionCell()
            cell.isSquadMember = viewModel.isSquadMember
            cell.button.addTarget(self, action: #selector(didPressAction), for: .touchUpInside)
            return cell
        case .biography:
            let cell = BiographyCell()
            cell.biographyLabel.text = viewModel.character.biography
            return cell
        }
    }
}

//MARK: ACTION
extension DetailViewController {
    @objc private func didPressAction() {
        if viewModel!.isSquadMember {
            self.presentConfirmation()
        }
        else {
            viewModel?.recruit()
            updateSquadList = true
        }
    }
}

//MARK: FIRE CONFIRMATION
extension DetailViewController {
    func presentConfirmation() {
        let alertView = UIAlertController(title: "Confirmation", message: "Are you sure you want to remove \(self.viewModel!.character.name)?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            self.viewModel?.fire()
            self.updateSquadList = true
        }
        let noAction = UIAlertAction(title: "No", style: .cancel)
        alertView.addAction(noAction)
        alertView.addAction(yesAction)
        self.present(alertView,animated: true)
    }
}

//MARK: BINDING VIEW MODEL
extension DetailViewController {
    private func bindingViewModel() {
        viewModel?.$isSquadMember.sink(receiveValue: { _ in
            self.tableView.reloadData()
        })
            .store(in: &cancellables)
    }
}
