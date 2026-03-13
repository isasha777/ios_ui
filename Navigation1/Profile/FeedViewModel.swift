//
//  FeedViewModel.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 05.02.2026.
//

import UIKit

final class FeedViewModel {

    // MARK: - Output (bindings)

    var onResultTextChange: ((String) -> Void)?
    var onResultColorChange: ((UIColor) -> Void)?
    var onShowAlert: ((String, String) -> Void)?

    // MARK: - Dependencies

    private let model: FeedModel

    init(model: FeedModel) {
        self.model = model
    }

    // MARK: - Input (from View)

    func didTapCheck(word: String?) {
        let text = (word ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

        guard !text.isEmpty else {
            onShowAlert?("Пустое значение", "Введите слово для проверки.")
            return
        }

        model.check(word: text) { [weak self] isCorrect in
            guard let self else { return }

            if isCorrect {
                self.onResultTextChange?("Верно ✅")
                self.onResultColorChange?(.systemGreen)
            } else {
                self.onResultTextChange?("Неверно ❌")
                self.onResultColorChange?(.systemRed)
            }
        }
    }
}
