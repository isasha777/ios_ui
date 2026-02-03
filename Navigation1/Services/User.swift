//
//  User.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 28.01.2026.
//

import UIKit

final class User {
    let login: String
    let fullName: String
    let avatar: UIImage
    var status: String

    init(login: String, fullName: String, avatar: UIImage, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}
