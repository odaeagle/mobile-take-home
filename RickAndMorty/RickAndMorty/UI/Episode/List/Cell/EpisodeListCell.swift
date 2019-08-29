import UIKit

struct EpisodeListCellUIModel {
    let title: String
    let preloadModel: EpisodeDetailPreloadModel
}

extension EpisodeListCellUIModel {
    init(episode: Episode) {
        self.init(title: episode.name,
                  preloadModel: EpisodeDetailPreloadModel(
                    id: episode.id,
                    name: episode.name)
        )
    }
}

class EpisodeListCell: UITableViewCell {

    static let identifier = "EpisodeList"

    private let titleLabel = UILabel().apply {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .black
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: 8,
                                  y: 0,
                                  width: contentView.bounds.width - 16,
                                  height: contentView.bounds.height)
    }

    func bind(_ model: EpisodeListCellUIModel) {
        titleLabel.text = model.title
    }
}
