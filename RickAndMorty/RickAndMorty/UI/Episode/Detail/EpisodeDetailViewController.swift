import UIKit

struct EpisodeDetailPreloadModel {
    let id: String
    let name: String
}

private let headerHeight = CGFloat(50)

class EpisodeDetailViewController: UIViewController {

    private var preloadModel: EpisodeDetailPreloadModel!
    private var episode: Episode?
    private var models = [CharacterDetailCellUIModel]()
    private var filteredModels = [CharacterDetailCellUIModel]()

    private var filterControl = UISegmentedControl().apply {
        $0.insertSegment(withTitle: "All", at: 0, animated: false)
        $0.insertSegment(withTitle: "Alive", at: 1, animated: false)
        $0.insertSegment(withTitle: "Dead", at: 2, animated: false)
        $0.insertSegment(withTitle: "unknown", at: 3, animated: false)
    }

    private var divider = UIView().apply {
        $0.backgroundColor = UIColor(white: 0, alpha: 0.5)
    }

    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        return UICollectionViewFlowLayout().apply {
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 0
        }
    }()

    private lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).apply {
            $0.backgroundColor = .white
            $0.register(CharacterDetailCell.self,
                        forCellWithReuseIdentifier: CharacterDetailCell.identifier)
            $0.dataSource = self
            $0.delegate = self
        }
    }()

    convenience init(preloadModel: EpisodeDetailPreloadModel) {
        self.init()
        self.preloadModel = preloadModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(filterControl)
        view.addSubview(divider)
        view.addSubview(collectionView)

        filterControl.addTarget(self, action: #selector(onFilterControlChanged(sender:)), for: .valueChanged)
        bindPreloadModel()
        fetchCharacters()
    }

    private func bindPreloadModel() {
        title = preloadModel.name
    }

    private func fetchCharacters() {
        filterControl.isEnabled = false
        EpisodeService.shared.fetchEpisodeDetail(id: preloadModel.id)
            .map { [weak self] (episode) -> [CharacterDetailCellUIModel] in
                self?.episode = episode
                return (episode.characters ?? []).map { CharacterDetailCellUIModel(character: $0) }
            }.subscribe { [weak self] (models, error) in
                if let self = self {
                    if error != nil {
                        /* ERROR */
                    } else {
                        self.models.append(contentsOf: models ?? [])
                        self.collectionView.reloadData()
                        self.filterControl.isEnabled = true
                        self.filterControl.selectedSegmentIndex = 0
                        self.onFilterControlChanged(sender: self.filterControl)
                    }
                }
        }
    }

    @objc private func onFilterControlChanged(sender: UISegmentedControl) {
        filteredModels.removeAll()
        switch sender.selectedSegmentIndex {
        case 0:
            filteredModels.append(contentsOf: models)
        case 1:
            filteredModels.append(contentsOf: models.filter { $0.status == .alive })
        case 2:
            filteredModels.append(contentsOf: models.filter { $0.status == .dead })
        case 3:
            filteredModels.append(contentsOf: models.filter { $0.status == .unknown })
        default:
            break
        }
        collectionView.reloadData()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let width = view.bounds.width
        let height = view.bounds.height
        collectionViewLayout.itemSize = CGSize(width: width / 2 , height: width / 2)

        filterControl.sizeToFit()
        filterControl.center = CGPoint(x: width / 2 , y: view.safeAreaInsets.top + headerHeight / 2)
        divider.frame = CGRect(x: 0,
                               y: view.safeAreaInsets.top + headerHeight,
                               width: width,
                               height: 1)
        collectionView.frame = CGRect(x: 0,
                                      y: view.safeAreaInsets.top + headerHeight + 1,
                                      width: width,
                                      height: height - view.safeAreaInsets.top - headerHeight - 1)
    }
}

extension EpisodeDetailViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = filteredModels[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterDetailCell.identifier,
                                                      for: indexPath)
        if let cell = cell as? CharacterDetailCell {
            cell.bind(model)
        }
        return cell
    }
}

extension EpisodeDetailViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = filteredModels[indexPath.row]
        let controller = CharacterDetailViewController(preloadModel: model.preloadModel)
        navigationController?.pushViewController(controller, animated: true)
    }
}
