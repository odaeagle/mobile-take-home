import UIKit

struct EpisodeListCellUIModel {
    let title: String
    let subtitle: NSAttributedString
    let preloadModel: EpisodeDetailPreloadModel
}

extension EpisodeListCellUIModel {
    init(episode: Episode) {
        let subtitle = NSMutableAttributedString()
        subtitle.append(NSAttributedString(
            string: episode.episode,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        )
        subtitle.append(NSAttributedString(
            string: "  \u{2022}  "))
        subtitle.append(NSAttributedString(
            string: episode.air_date,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray,
                         NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 16)]))

        self.init(title: episode.name,
                  subtitle: subtitle,
                  preloadModel: EpisodeDetailPreloadModel(
                    id: episode.id,
                    name: episode.name)
        )
    }
}

private let padding = CGFloat(12)

class EpisodeListCell: UITableViewCell {

    static let identifier = "EpisodeList"

    private let titleLabel = UILabel().apply {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .black
    }

    private let subtitleLabel = UILabel().apply {
        $0.textColor = .darkGray
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        /* I wrote lib to layout the view using just one line
         no, im not talking about storyboard or xib or auto layout or snapKit-ish
         im talking about android style, almost like swift-ui
         but it's way too much code to bring in... so
         frame code then */

        titleLabel.sizeToFit()
        titleLabel.frame = CGRect(x: padding,
                                  y: contentView.bounds.height / 2 - titleLabel.bounds.height - 4,
                                  width: contentView.bounds.width - padding * 2,
                                  height: titleLabel.bounds.height)
        subtitleLabel.sizeToFit()
        subtitleLabel.frame = CGRect(x: padding,
                                     y: contentView.bounds.height / 2 + 4,
                                     width: contentView.bounds.width - padding * 2,
                                     height: titleLabel.bounds.height)

    }

    func bind(_ model: EpisodeListCellUIModel) {
        titleLabel.text = model.title
        subtitleLabel.attributedText = model.subtitle
    }
}
