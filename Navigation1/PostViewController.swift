import UIKit

final class PostViewController: UIViewController {

    private let post: Post

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = post.title
        view.backgroundColor = .systemTeal

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Info",
            style: .plain,
            target: self,
            action: #selector(handleInfoTap)
        )
    }

    @objc private func handleInfoTap() {
        let infoViewController = InfoViewController()
        let modalNavigation = UINavigationController(rootViewController: infoViewController)
        present(modalNavigation, animated: true)
    }
}

