import UIKit



class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        let single = RMService.shared.fetchEpisodeList()
        single.subscribe { (result, error) in
            print("XXXXX", result)
            print("XXXXX", error)
        }
    }
}

