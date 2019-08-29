import UIKit

struct CharacterDetailPreloadModel {
    let id: String
    let name: String
    let imageUrl: String
}

class CharacterDetailViewController: UIViewController {

    private var preloadModel: CharacterDetailPreloadModel!

    private let imageView = UIImageView().apply {
        $0.backgroundColor = .white
    }

    convenience init(preloadModel: CharacterDetailPreloadModel) {
        self.init()
        self.preloadModel = preloadModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(imageView)

        bindPreloadModel()
    }

    private func bindPreloadModel() {
        title = preloadModel.name
        RMApi.shared.downloadImage(url: preloadModel.imageUrl)
            .subscribe { [weak self] (image, error) in
                self?.imageView.image = image
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let width = view.bounds.width

        imageView.frame = CGRect(x: 0,
                                 y: view.safeAreaInsets.top,
                                 width: width,
                                 height: width)
    }
}
