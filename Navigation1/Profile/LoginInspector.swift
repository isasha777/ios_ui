//
//  LoginInspector.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 02.02.2026.
//
struct LoginInspector: LoginViewControllerDelegate {

    func check(login: String, password: String) -> Bool {
        Checker.shared.check(login: login, password: password)
    }
}
