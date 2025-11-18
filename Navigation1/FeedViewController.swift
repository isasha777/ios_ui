import UIKit

final class FeedViewController: UIViewController {

    private lazy var stack: UIStackView = {
        let st = UIStackView()
        st.axis = .vertical
        st.alignment = .fill
        st.distribution = .fillEqually
        st.spacing = 10
        st.translatesAutoresizingMaskIntoConstraints = false
        return st
    }()

    // Пример поста для экрана PostViewController
    private let demoPost = Post(
        author: "Hipster Cat",
        description: "Мой первый пост в ленте. Здесь мог бы быть любой текст.",
        image: "post_1",   // имя картинки в Assets, можешь поменять
        likes: 100,
        views: 321
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Feed"

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            stack.heightAnchor.constraint(equalToConstant: 110)
        ])

        let first = makeButton(title: "Open Post A", action: #selector(openPostA))
        let second = makeButton(title: "Open Post B", action: #selector(openPostB))
        stack.addArrangedSubview(first)
        stack.addArrangedSubview(second)
    }

    private func makeButton(title: String, action: Selector) -> UIButton {
        let b = UIButton(type: .system)
        b.setTitle(title, for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .systemBlue
        b.layer.cornerRadius = 10
        b.heightAnchor.constraint(equalToConstant: 50).isActive = true
        b.addTarget(self, action: action, for: .touchUpInside)
        return b
    }

    @objc private func openPostA() {
        let vc = PostViewController(post: demoPost)
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func openPostB() {
        // можешь сделать другой пост, пока для примера тот же
        let secondPost = Post(
            author: "netology.ru",
            description: "Ещё один пост для демонстрации перехода.",
            image: "post_2",
            likes: 55,
            views: 200
        )
        let vc = PostViewController(post: secondPost)
        navigationController?.pushViewController(vc, animated: true)
    }
}

