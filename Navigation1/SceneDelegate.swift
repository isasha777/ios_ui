import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        // --- Feed tab ---
        let feedVC = FeedViewController()
        feedVC.title = "Feed"
        let feedNav = UINavigationController(rootViewController: feedVC)
        feedNav.tabBarItem = UITabBarItem(
            title: "Feed",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        // --- Profile tab starts with LogInViewController ---
        let loginVC = LogInViewController()
        let profileNav = UINavigationController(rootViewController: loginVC)
        profileNav.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        // --- Tab bar controller ---
        let tabBar = UITabBarController()
        tabBar.viewControllers = [feedNav, profileNav]

        // --- Window setup ---
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
        self.window = window
    }

    // Остальные методы жизненного цикла можно не трогать,
    // но оставляю заготовки на будущее:
    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

