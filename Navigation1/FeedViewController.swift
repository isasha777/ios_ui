import UIKit

final class FeedViewController: UIViewController {

    private lazy var openPostButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Открыть пост"
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleOpenPostTap), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(openPostButton)
        NSLayoutConstraint.activate([
            openPostButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openPostButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            openPostButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func handleOpenPostTap() {
        let post = Post(title: "Мой первый пост")
        let postViewController = PostViewController(post: post)
        navigationController?.pushViewController(postViewController, animated: true)
    }
}

