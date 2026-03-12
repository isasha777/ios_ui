//
//  TestUserService.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 28.01.2026.
//

import UIKit

final class TestUserService: UserService {

    private let testUser: User

    init(testUser: User) {
        self.testUser = testUser
    }

    func getUser(login: String) -> User? {
        // В Debug можно возвращать тестового пользователя независимо от введённого логина,
        // или наоборот — только если логин совпал. Обычно для теста удобнее "всегда".
        return testUser
    }
}
