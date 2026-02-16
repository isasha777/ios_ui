//
//  AppCoordinator.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 16.02.2026.
//

import UIKit

final class AppCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []

    private let window: UIWindow
    private let tabBarController = UITabBarController()

    private let feedNavigationController = UINavigationController()
    private let profileNavigationController = UINavigationController()

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        // Feed flow
        let feedCoordinator = FeedCoordinator(navigationController: feedNavigationController)
        feedCoordinator.tabBarItem = UITabBarItem(
            title: "Лента",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        addChild(feedCoordinator)
        feedCoordinator.start()

        // Profile flow
        let profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        profileCoordinator.tabBarItem = UITabBarItem(
            title: "Профиль",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.fill")
        )
        addChild(profileCoordinator)
        profileCoordinator.start()

        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
