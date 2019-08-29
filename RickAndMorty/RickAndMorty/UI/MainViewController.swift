import UIKit



class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        let single = EpisodeService.shared.fetchEpisodeList()
        single.subscribe { (result, error) in
            print("XXXXX", result)
            print("XXXXX", error)
        }

        let single2 = EpisodeService.shared.fetchEpisodeDetail(id: "1")
        single2.subscribe { (result, error) in
            print("XXXXX", result)
            print("XXXXX", error)
        }

        let single3 = CharacterService.shared.fetchCharacterDetail(id: "1")
        single3.subscribe { (result, error) in
            print("XXXXX", result)
            print("XXXXX", error)
        }
    }
}

