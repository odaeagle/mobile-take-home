import UIKit

class EpisodeListViewController: UIViewController {

    private var models = [EpisodeListCellUIModel]()

    lazy var tableView: UITableView = {
        return UITableView().apply {
            $0.register(EpisodeListCell.self,
                        forCellReuseIdentifier: EpisodeListCell.identifier)
            $0.dataSource = self
            $0.delegate = self
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rickipedia"
        view.backgroundColor = .white
        view.addSubview(tableView)

        EpisodeService.shared.fetchEpisodeList()
            .map { (results) -> [EpisodeListCellUIModel] in
                return results.map { EpisodeListCellUIModel(episode: $0) }
            }.subscribe { [weak self] (models, error) in
                if let self = self {
                    if error != nil {
                        /* ERROR */
                    } else {
                        self.models.append(contentsOf: models ?? [])
                        self.tableView.reloadData()
                    }
                }
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension EpisodeListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeListCell.identifier, for: indexPath)
        if let cell = cell as? EpisodeListCell {
            cell.bind(model)
        }
        return cell
    }
}

extension EpisodeListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        let controller = EpisodeDetailViewController(preloadModel: model.preloadModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}
