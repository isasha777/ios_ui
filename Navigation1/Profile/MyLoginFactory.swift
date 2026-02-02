//
//  MyLoginFactory.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 02.02.2026.
//

struct MyLoginFactory: LoginFactory {

    func makeLoginInspector() -> LoginInspector {
        LoginInspector()
    }
}
