import UIKit
import StorageService

final class PostViewController: UIViewController {

    private let post: Post

    private let textLabel: UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        l.font = .systemFont(ofSize: 16)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Раньше было title = post.title — теперь используем author
        title = post.author
        view.backgroundColor = .systemBackground

        textLabel.text = post.description

        view.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        // если у тебя был UIBarButtonItem "Info" — можешь вернуть сюда так же, как раньше
    }
}

