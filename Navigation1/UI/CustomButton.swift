//
//  CustomButton.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 04.02.2026.
//

import UIKit

final class CustomButton: UIButton {

    private var onTap: (() -> Void)?

    // удобный инициализатор
    init(
        title: String,
        titleColor: UIColor = .white,
        backgroundColor: UIColor = .systemBlue,
        cornerRadius: CGFloat = 10,
        onTap: (() -> Void)? = nil
    ) {
        self.onTap = onTap
        super.init(frame: .zero)

        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        layer.cornerRadius = cornerRadius
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)

        translatesAutoresizingMaskIntoConstraints = false
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // чтобы можно было назначить обработчик после создания
    func setOnTap(_ handler: @escaping () -> Void) {
        onTap = handler
    }

    @objc private func buttonTapped() {
        onTap?()
    }
}
