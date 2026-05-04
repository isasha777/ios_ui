//
//  UserService.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 28.01.2026.
//

import Foundation

protocol UserService {
    func getUser(login: String) -> User?
}
