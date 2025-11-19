import UIKit

final class ProfileViewController: UIViewController {

    private let tableView = UITableView(frame: .zero, style: .plain)

    private let posts: [Post] = [
        Post(author: "vedmak.official",
             description: "Новые кадры со съёмок второго сезона сериала «Ведьмак».",
             image: "post_1",
             likes: 240,
             views: 312),
        Post(author: "netology.ru",
             description: "Нетология. Меняем карьеру через образование.",
             image: "post_2",
             likes: 120,
             views: 456),
        Post(author: "swift.dev",
             description: "От 'Hello, World' до первого сложного iOS-приложения — один курс.",
             image: "post_3",
             likes: 766,
             views: 893),
        Post(author: "cat.content",
             description: "Котики, код и кофе — идеальное комбо.",
             image: "post_4",
             likes: 999,
             views: 1500)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view.backgroundColor = .systemBackground
        setupTableView()
    }

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

        tableView.register(PostTableViewCell.self,
                           forCellReuseIdentifier: PostTableViewCell.reuseIdentifier)

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
}

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

        cell.configure(with: posts[indexPath.row])
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        ProfileHeaderView()
    }

    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        220
    }
}

