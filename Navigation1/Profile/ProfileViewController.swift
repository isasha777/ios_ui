import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - UI

    private let tableView = UITableView(frame: .zero, style: .plain)

    // Один экземпляр хедера (важно для systemLayoutSizeFitting)
    private let profileHeaderView = ProfileHeaderView()

    // MARK: - Data

    private let posts = PostStorage.posts

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        view.backgroundColor = .systemBackground

        setupTableView()
    }

    // MARK: - Setup

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: PostTableViewCell.reuseIdentifier
        )

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200

        // На всякий случай можно подсказать таблице, что заголовок тоже динамический
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 220
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        posts.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? PostTableViewCell else {
            return UITableViewCell()
        }

        let post = posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        // один и тот же headerView
        return profileHeaderView
    }

    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        // ВАЖНО: даём Auto Layout возможность посчитать высоту
        // для заданной ширины таблицы

        // Обновляем лейаут, чтобы констрейнты были актуальны
        profileHeaderView.setNeedsLayout()
        profileHeaderView.layoutIfNeeded()

        let targetSize = CGSize(
            width: tableView.bounds.width,
            height: UIView.layoutFittingCompressedSize.height
        )

        let size = profileHeaderView.systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        return size.height
    }
}

