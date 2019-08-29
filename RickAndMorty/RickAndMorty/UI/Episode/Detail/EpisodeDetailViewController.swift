import UIKit

struct EpisodeDetailPreloadModel {
    let id: String
    let name: String
}

class EpisodeDetailViewController: UIViewController {

    var preloadModel: EpisodeDetailPreloadModel!

    convenience init(preloadModel: EpisodeDetailPreloadModel) {
        self.init()
        self.preloadModel = preloadModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
