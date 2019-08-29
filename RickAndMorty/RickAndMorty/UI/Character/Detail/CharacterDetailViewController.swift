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

    private let descriptionLabel = UILabel().apply {
        $0.numberOfLines = 0
    }

    convenience init(preloadModel: CharacterDetailPreloadModel) {
        self.init()
        self.preloadModel = preloadModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        /* this is not exactly where i usually use also, but just give you an idea
           how this help organize code */
        view.also {
            $0.backgroundColor = .white
            $0.addSubview(descriptionLabel)
            $0.addSubview(imageView)
        }

        bindPreloadModel()
        fetchDetail()
    }

    private func bindPreloadModel() {
        title = preloadModel.name
        RMApi.shared.downloadImage(url: preloadModel.imageUrl)
            .subscribe { [weak self] (image, error) in
                self?.imageView.image = image
        }
    }

    private func fetchDetail() {
        CharacterService.shared.fetchCharacterDetail(id: preloadModel.id)
            .map { (character) -> CharacterDetailUIModel in
                return CharacterDetailUIModel(character: character)
            }.subscribe { [weak self] (model, error) in
                if let model = model {
                    self?.bind(model)
                } else {
                    /* I will ignore error handling */
                }
        }
    }

    private func bind(_ model: CharacterDetailUIModel) {
        /* I know i know i should wrap them in scrollview, but im lazy ok??? */

        descriptionLabel.attributedText = model.description
        view.setNeedsLayout()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let width = view.bounds.width

        imageView.frame = CGRect(x: 0,
                                 y: view.safeAreaInsets.top,
                                 width: width,
                                 height: width)
        let size = descriptionLabel.sizeThatFits(CGSize(width: width - 24, height: CGFloat.greatestFiniteMagnitude))
        descriptionLabel.frame = CGRect(x: 12,
                                        y: imageView.frame.maxY + 12,
                                        width: width - 24,
                                        height: size.height)
    }
}
