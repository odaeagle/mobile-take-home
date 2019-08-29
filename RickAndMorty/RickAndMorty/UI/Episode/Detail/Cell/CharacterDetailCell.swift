import UIKit

struct CharacterDetailCellUIModel {
    let title: String
    let preloadModel: CharacterDetailPreloadModel
    let url: String
    let status: CharacterStatus
    let shouldDim: Bool
    let iconName: String?
}

extension CharacterDetailCellUIModel {
    init(character: Character) {
        title = character.name
        preloadModel = CharacterDetailPreloadModel(id: character.id,
                                                   name: character.name)
        url = character.image
        status = character.status
        switch character.status {
        case .alive:
            iconName = nil
            shouldDim = false
        case .dead:
            iconName = "ic_dead"
            shouldDim = true
        case .unknown:
            iconName = "ic_question"
            shouldDim = false
        }
    }
}

class CharacterDetailCell: UICollectionViewCell {

    static let identifier = "CharacterDetailCell"

    private let imageView = UIImageView().apply {
        $0.backgroundColor = .white
    }

    private let nameLabel = UILabel().apply {
        $0.textColor = .black
        $0.backgroundColor = UIColor(white: 1, alpha: 0.75)
        $0.font = UIFont.systemFont(ofSize: 18)
        $0.textAlignment = .center
    }

    private let cover = UIView()

    private let iconImageView = UIImageView().apply {
        $0.backgroundColor = .white
        $0.contentMode = .scaleAspectFit
        $0.bounds = CGRect(origin: .zero, size: CGSize(width: 48, height: 48))
        $0.layer.cornerRadius = 24
        $0.layer.masksToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
        contentView.addSubview(cover)
        contentView.addSubview(nameLabel)
        contentView.addSubview(iconImageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let width = contentView.bounds.width
        let height = contentView.bounds.height
        imageView.frame = contentView.bounds
        nameLabel.frame = CGRect(x: 0, y: height - 32, width: width, height: 32)
        cover.frame = contentView.bounds

        iconImageView.center = CGPoint(x: width - iconImageView.bounds.width / 2 - 8,
                                       y: iconImageView.bounds.width / 2 + 8)
    }

    func bind(_ model: CharacterDetailCellUIModel) {
        nameLabel.text = model.title

        imageView.image = nil
        RMApi.shared.downloadImage(url: model.url)
            .subscribe { [weak self] (image, error) in
                self?.imageView.image = image
        }

        if model.shouldDim {
            cover.backgroundColor = UIColor(white: 0, alpha: 0.5)
        } else {
            cover.backgroundColor = .clear
        }

        if let iconName = model.iconName {
            iconImageView.isHidden = false
            iconImageView.image = UIImage(named: iconName)
        } else {
            iconImageView.isHidden = true
            iconImageView.image = nil
        }
    }
}
