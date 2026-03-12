//
//  FeedModel.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 04.02.2026.
//

import Foundation

final class FeedModel {

    private let secretWord: String

    init(secretWord: String = "swift") {
        self.secretWord = secretWord.lowercased()
    }

    /// Нотификация результата через completion (самый простой и чистый вариант)
    func check(word: String, completion: (Bool) -> Void) {
        completion(word.lowercased() == secretWord)
    }
}
