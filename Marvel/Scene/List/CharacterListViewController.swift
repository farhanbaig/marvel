import UIKit
import Combine


fileprivate let reuseIdentifier = "ListRowCellId"

fileprivate enum Section {
    case squad
    case list
}

class CharacterListViewController: UITableViewController {
    var cancellables = Set<AnyCancellable>()
    var viewModel: ListViewModel!
    
    init(viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate var sections: [Section] = [.list]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.backgroundColor = .darkBackground
        tableView.register(ListRowCell.self, forCellReuseIdentifier: reuseIdentifier)
        setupNavbar()
        bindViewModel()
        viewModel.fetch()
    }
}

extension CharacterListViewController {
    private func setupNavbar() {
        let titleImageView = UIImageView(image: UIImage(named: "Logo"))
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
    }
}

extension CharacterListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .squad:
            return 1
        case .list:
            return viewModel.characters.value.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch  sections[indexPath.section] {
        case .squad:
            let cell = SquadCell()
            cell.squad = viewModel.squad.value
            cell.$selectedCharacter.sink { [weak self] character in
                guard let character = character else {return}
                self?.navigateToDetail(character: character)
            }
            .store(in: &cancellables)
            return cell
        case .list:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! ListRowCell
            cell.character = viewModel.characters.value[indexPath.row]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetail(character: viewModel.characters.value[indexPath.row])
    }
}


extension CharacterListViewController {
    private func navigateToDetail(character: CharacterViewModel) {
        let detailViewModel = DetailViewModel(squadService: SquadFetcher(), character: character)
        let detailVC = DetailViewController(viewModel: detailViewModel)
        detailVC.$updateSquadList.sink { [weak self] update in
            if update {
                self?.viewModel.loadSquad()
            }
        }
        .store(in: &cancellables)
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}


//MARK: BIND VIEW MODEL
extension CharacterListViewController {
    private func bindViewModel() {
        // view model binding
        viewModel.characters.sink { [weak self] _ in
            self?.tableView.reloadData()
        }
        .store(in: &cancellables)
        viewModel.$error.sink { message in
            guard let message = message else {return}
            self.presentAlert(message: message)
        }
        .store(in: &cancellables)
        
        viewModel.squad.sink { [weak self] squad in
            if squad.isEmpty {
                self?.sections = [.list]
            }
            else {
                self?.sections = [.squad,.list]
            }
            self?.tableView.reloadData()
        }
        .store(in: &cancellables)
    }
}


extension CharacterListViewController {
    func presentAlert(message: String) {
        let alertView = UIAlertController(title: "Failure", message: message, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Retry", style: .default) { _ in
            self.viewModel.fetch()
        }
        alertView.addAction(yesAction)
        self.present(alertView,animated: true)
    }
}
