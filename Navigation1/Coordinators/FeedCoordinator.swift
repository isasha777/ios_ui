import UIKit
import StorageService

final class FeedCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

    let navigationController: UINavigationController
    var tabBarItem: UITabBarItem? {
        didSet { navigationController.tabBarItem = tabBarItem }
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let feedVC = FeedViewController()
        feedVC.coordinator = self
        navigationController.setViewControllers([feedVC], animated: false)
    }

    // ✅ Навигация на пост теперь принимает Post
    func showPost(post: Post) {
        let postVC = PostViewController(post: post)
        navigationController.pushViewController(postVC, animated: true)
    }
}
