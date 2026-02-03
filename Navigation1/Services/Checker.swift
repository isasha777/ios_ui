//
//  Checker.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 02.02.2026.
//

import Foundation

final class Checker {

    static let shared = Checker()

    private let login: String = "cat"
    private let password: String = "1234"

    private init() {}

    func check(login: String, password: String) -> Bool {
        self.login == login && self.password == password
    }
}

