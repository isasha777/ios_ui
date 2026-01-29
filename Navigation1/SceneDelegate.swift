import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = scene as? UIWindowScene else { return }

        // Release user
        let prodUser = User(
            login: "cat",
            fullName: "Hipster Cat",
            avatar: UIImage(systemName: "person.circle.fill") ?? UIImage(),
            status: "Waiting for something..."
        )

        // Debug user
        let debugUser = User(
            login: "test",
            fullName: "Debug User",
            avatar: UIImage(systemName: "person.circle.fill") ?? UIImage(),
            status: "I am Debug!"
        )

        let userService: UserService
        #if DEBUG
        userService = TestUserService(testUser: debugUser)
        #else
        userService = CurrentUserService(user: prodUser)
        #endif

        // Feed
        let feedVC = FeedViewController()
        let feedNav = UINavigationController(rootViewController: feedVC)
        feedNav.tabBarItem = UITabBarItem(
            title: "Лента",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )

        // Profile -> Login
        let loginVC = LogInViewController(userService: userService) // ✅ ВОТ ЭТО РЕШАЕТ ОШИБКУ
        let profileNav = UINavigationController(rootViewController: loginVC)
        profileNav.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )

        let tabBar = UITabBarController()
        tabBar.viewControllers = [feedNav, profileNav]

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBar
        window.makeKeyAndVisible()
        self.window = window
    }
}

