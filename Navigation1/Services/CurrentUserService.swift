//
//  CurrentUserService.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 28.01.2026.
//

import UIKit

final class CurrentUserService: UserService {

    private let user: User

    // Инициализируем сервис конкретным пользователем
    init(user: User) {
        self.user = user
    }

    func getUser(login: String) -> User? {
        login == user.login ? user : nil
    }
}
