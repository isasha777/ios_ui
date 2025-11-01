import UIKit

final class ProfileViewController: UIViewController {

    private let headerView = ProfileHeaderView()
    private let bottomButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Bottom Action", for: .normal) // поменяли title
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .systemBlue
        b.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .lightGray

        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        view.addSubview(bottomButton)

        NSLayoutConstraint.activate([
            // Header 0/0 по сторонам, к safeArea сверху, высота 220
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 220),

            // Bottom button 0/0 по сторонам и к safe area снизу
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        bottomButton.addTarget(self, action: #selector(handleBottomTap), for: .touchUpInside)
    }

    @objc private func handleBottomTap() {
        print("Bottom button tapped")
    }
}

