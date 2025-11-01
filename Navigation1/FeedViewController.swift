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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Feed"

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            stack.heightAnchor.constraint(equalToConstant: 110) // две кнопки ~ 50 + spacing 10
        ])

        // Кнопки
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
        let post = Post(title: "Post A")
        let vc = PostViewController(post: post)
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc private func openPostB() {
        let post = Post(title: "Post B")
        let vc = PostViewController(post: post)
        navigationController?.pushViewController(vc, animated: true)
    }
}

