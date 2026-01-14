//
//  PostStorage.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 21.11.2025.
//

import Foundation
import StorageService

struct PostStorage {
    static let posts: [Post] = [
        Post(
            author: "vedmak.official",
            description: "Новые кадры со съёмок второго сезона сериала «Ведьмак».",
            image: "post_1",
            likes: 240,
            views: 312
        ),
        Post(
            author: "netology.ru",
            description: "Нетология. Меняем карьеру через образование.",
            image: "post_2",
            likes: 120,
            views: 456
        ),
        Post(
            author: "swift.dev",
            description: "От \"Hello, World\" до первого сложного iOS-приложения — один курс.",
            image: "post_3",
            likes: 766,
            views: 893
        ),
        Post(
            author: "cat.content",
            description: "Котики, код и кофе — идеальное комбо.",
            image: "post_4",
            likes: 999,
            views: 1500
        )
    ]
}
