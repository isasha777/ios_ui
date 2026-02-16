//
//  ProfileCoordinato.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 16.02.2026.
//

import UIKit

final class ProfileCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

    let navigationController: UINavigationController
    var tabBarItem: UITabBarItem? {
        didSet { navigationController.tabBarItem = tabBarItem }
    }

    // UserService оставляем как есть (Debug/Release)
    private let userService: UserService
    private let loginDelegate: LoginViewControllerDelegate

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController

        // Собираем зависимости (как у тебя было в SceneDelegate)
        let prodUser = User(
            login: "cat",
            fullName: "Hipster Cat",
            avatar: UIImage(systemName: "person.circle.fill") ?? UIImage(),
            status: "Waiting for something..."
        )

        let debugUser = User(
            login: "cat",
            fullName: "Debug Cat",
            avatar: UIImage(systemName: "person.circle.fill") ?? UIImage(),
            status: "I am Debug!"
        )

        #if DEBUG
        self.userService = TestUserService(testUser: debugUser)
        #else
        self.userService = CurrentUserService(user: prodUser)
        #endif

        // Фабрика инспектора (из прошлых заданий)
        let factory: LoginFactory = MyLoginFactory()
        self.loginDelegate = factory.makeLoginInspector()
    }

    func start() {
        showLogin()
    }

    private func showLogin() {
        let loginVC = LogInViewController(userService: userService)
        loginVC.coordinator = self
        loginVC.loginDelegate = loginDelegate

        navigationController.setViewControllers([loginVC], animated: false)
        navigationController.navigationBar.isHidden = true
    }

    func showProfile(user: User) {
        let profileVC = ProfileViewController()
        profileVC.user = user
        profileVC.coordinator = self

        navigationController.pushViewController(profileVC, animated: true)
        navigationController.navigationBar.isHidden = true
    }
}
