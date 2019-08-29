import UIKit

struct EpisodeDetailPreloadModel {
    let id: String
    let name: String
}

class EpisodeDetailViewController: UIViewController {

    var preloadModel: EpisodeDetailPreloadModel!

    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        return UICollectionViewFlowLayout().apply {
            $0.minimumInteritemSpacing = 0
            $0.minimumLineSpacing = 0
        }
    }()

    lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout).apply {
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
        view.backgroundColor = .red

        view.addSubview(collectionView)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let width = view.bounds.width
        let height = view.bounds.height
        collectionViewLayout.itemSize = CGSize(width: width / 2 , height: width / 2)
        collectionView.frame = CGRect(x: 0,
                                      y: view.safeAreaInsets.top + 100,
                                      width: width,
                                      height: height - view.safeAreaInsets.top - 100)
    }
}

extension EpisodeDetailViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterDetailCell.identifier,
                                                      for: indexPath)
        return cell
    }
}

extension EpisodeDetailViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
