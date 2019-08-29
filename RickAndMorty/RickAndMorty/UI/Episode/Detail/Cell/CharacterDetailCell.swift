import UIKit

struct CharacterDetailCellUIModel {
    let title: String
    let preloadModel: CharacterDetailPreloadModel
}

extension CharacterDetailCellUIModel {
    init(character: Character) {
        self.init(title: character.name,
                  preloadModel: CharacterDetailPreloadModel(
                    id: character.id,
                    name: character.name)
        )
    }
}

class CharacterDetailCell: UICollectionViewCell {

    static let identifier = "CharacterDetailCell"

    let nameLabel = UILabel().apply {
        $0.textColor = .black
        $0.backgroundColor = UIColor(white: 1, alpha: 0.5)
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textAlignment = .center
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .blue
        contentView.addSubview(nameLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let width = contentView.bounds.width
        let height = contentView.bounds.height
        nameLabel.frame = CGRect(x: 0, y: height - 30, width: width, height: 30)
    }

    func bind(_ model: CharacterDetailCellUIModel) {
        nameLabel.text = model.title
    }
}
