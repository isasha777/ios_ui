import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - UI

    private let tableView = UITableView(frame: .zero, style: .plain)

    // MARK: - Data

    private let posts = PostStorage.posts

    // список всех фото для галереи
    private let photoNames: [String] = [
        "post_1", "post_2", "photo_3", "photo_4",
        "photo_5", "photo_6", "photo_7", "photo_8",
        "photo_9", "photo_10", "photo_11", "photo_12"
    ]

    // один экземпляр шапки профиля
    private let profileHeaderView = ProfileHeaderView()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Profile"   // заголовок не виден, т.к. navBar скрыт

        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // navBar скрыт на экране профиля
        navigationController?.navigationBar.isHidden = true
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
            PhotosTableViewCell.self,
            forCellReuseIdentifier: PhotosTableViewCell.reuseIdentifier
        )
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: PostTableViewCell.reuseIdentifier
        )

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200

        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 220
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        // 0 — header + photos, 1 — посты
        2
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1      // одна ячейка с фото
        case 1:
            return posts.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PhotosTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? PhotosTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: photoNames)
            return cell

        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PostTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? PostTableViewCell else {
                return UITableViewCell()
            }
            let post = posts[indexPath.row]
            cell.configure(with: post)
            return cell

        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {

    // Header только для секции 0 (профиль)
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        section == 0 ? profileHeaderView : nil
    }

    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 220 : 0
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // переходим в фотогалерею только по ячейке Photos
        if indexPath.section == 0 {
            let vc = PhotosViewController(photoNames: photoNames)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

