import UIKit

final class ProfileViewController: UIViewController {

    // MARK: - UI

    private let tableView = UITableView(frame: .zero, style: .plain)

    private let profileHeaderView = ProfileHeaderView()

    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()

    private let expandedAvatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        button.layer.cornerRadius = 16
        button.alpha = 0
        return button
    }()

    // MARK: - Data

    private let posts = PostStorage.posts

    private let photoNames: [String] = [
        "photo_1", "photo_2", "photo_3", "photo_4",
        "photo_5", "photo_6", "photo_7", "photo_8",
        "photo_9", "photo_10", "photo_11", "photo_12"
    ]

    // MARK: - Animation state

    private var isAvatarExpanded = false
    private var avatarOriginalFrame: CGRect = .zero

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Profile"

        setupTableView()
        profileHeaderView.configureAvatarTap(target: self, action: #selector(avatarTapped))
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

    // MARK: - Avatar animation

    @objc private func avatarTapped() {
        guard !isAvatarExpanded else { return }
        guard let avatarImage = profileHeaderView.avatarImage else { return }

        isAvatarExpanded = true

        avatarOriginalFrame = profileHeaderView.avatarFrame(in: view)

        dimmedView.frame = view.bounds
        dimmedView.alpha = 0

        expandedAvatarImageView.image = avatarImage
        expandedAvatarImageView.frame = avatarOriginalFrame
        expandedAvatarImageView.layer.cornerRadius = avatarOriginalFrame.height / 2

        let buttonSize: CGFloat = 32
        let safeTop = view.safeAreaInsets.top
        closeButton.frame = CGRect(
            x: view.bounds.width - buttonSize - 16,
            y: safeTop + 16,
            width: buttonSize,
            height: buttonSize
        )
        closeButton.alpha = 0

        view.addSubview(dimmedView)
        view.addSubview(expandedAvatarImageView)
        view.addSubview(closeButton)

        profileHeaderView.setAvatarHidden(true)

        let targetWidth = view.bounds.width
        let scale = targetWidth / avatarOriginalFrame.width
        let targetHeight = avatarOriginalFrame.height * scale
        let targetFrame = CGRect(
            x: 0,
            y: (view.bounds.height - targetHeight) / 2,
            width: targetWidth,
            height: targetHeight
        )

        UIView.animate(withDuration: 0.5, animations: {
            self.dimmedView.alpha = 0.5
            self.expandedAvatarImageView.frame = targetFrame
            self.expandedAvatarImageView.layer.cornerRadius = 0
        }, completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeButton.alpha = 1
            }
        })
    }

    @objc private func closeButtonTapped() {
        guard isAvatarExpanded else { return }

        UIView.animate(withDuration: 0.3, animations: {
            self.closeButton.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.dimmedView.alpha = 0
                self.expandedAvatarImageView.frame = self.avatarOriginalFrame
                self.expandedAvatarImageView.layer.cornerRadius = self.avatarOriginalFrame.height / 2
            }, completion: { _ in
                self.dimmedView.removeFromSuperview()
                self.expandedAvatarImageView.removeFromSuperview()
                self.closeButton.removeFromSuperview()
                self.profileHeaderView.setAvatarHidden(false)
                self.isAvatarExpanded = false
            })
        })
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return posts.count
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PhotosTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? PhotosTableViewCell else { return UITableViewCell() }
            cell.configure(with: photoNames)
            return cell

        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PostTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? PostTableViewCell else { return UITableViewCell() }
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

        if indexPath.section == 0 {
            let vc = PhotosViewController(photoNames: photoNames)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

