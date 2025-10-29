import UIKit

final class ProfileViewController: UIViewController {

    private let profileHeaderView = ProfileHeaderView()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        view.backgroundColor = .lightGray

        view.addSubview(profileHeaderView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // отступ сверху = safe area (под навбаром)
        let top = view.safeAreaInsets.top

        // фиксированная высота блока шапки
        let headerHeight: CGFloat = 250

        profileHeaderView.frame = CGRect(
            x: 0,
            y: top,
            width: view.bounds.width,
            height: headerHeight
        )
    }
}

