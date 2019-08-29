import UIKit

struct CharacterDetailUIModel {

    /* I am just lazy : ) */
    let description: NSAttributedString

    init(character: Character) {
        /* I had bunch of extension to make these thing easier to write
           but you see .... */
        
        let description = NSMutableAttributedString()
        if let gender = character.gender {
            description.append(NSAttributedString(
                string: "Gender: ",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                             NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            )
            description.append(NSAttributedString(
                string: gender.rawValue,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
            )
            description.append(NSAttributedString(string: "\n"))
        }

        if let species = character.species {
            description.append(NSAttributedString(
                string: "Species: ",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                             NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            )
            description.append(NSAttributedString(
                string: species,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
            )
            description.append(NSAttributedString(string: "\n"))
        }

        if let type = character.type,
            type.count > 0 {
            description.append(NSAttributedString(
                string: "Type: ",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                             NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            )
            description.append(NSAttributedString(
                string: type,
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)])
            )
            description.append(NSAttributedString(string: "\n\n"))
        }

        if let episode = character.episode {
            description.append(NSAttributedString(
                string: "Appears In: ",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                             NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
            )
            description.append(NSAttributedString(string: "\n"))
            let episodes = episode.map { NSAttributedString(string: $0.name) }
            description.append(NSAttributedString.join(values: episodes,
                                                       seperator: NSAttributedString(string: "  \u{2022}  "))!)

        }

        self.description = description
    }
}
