import UIKit

final class ProfileHeaderView: UIView {

    // MARK: - State

    private var statusText: String = ""


    // MARK: - UI

    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatar") ?? UIImage(systemName: "person.circle")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true

        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor

        return imageView
    }()

    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()

    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()

    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Waiting for something..."
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.backgroundColor = .white

        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true

        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        textField.leftViewMode = .always

        // реагируем на ввод
        textField.addTarget(self,
                            action: #selector(statusTextChanged(_:)),
                            for: .editingChanged)
        return textField
    }()

    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemBlue

        // скругление и тень
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = false

        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4

        button.addTarget(self,
                         action: #selector(buttonPressed),
                         for: .touchUpInside)
        return button
    }()


    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray

        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(actionButton)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // MARK: - Layout

    override func layoutSubviews() {
        super.layoutSubviews()

        let topInset: CGFloat = 16
        let sideInset: CGFloat = 16

        // Аватар
        let avatarSize: CGFloat = 100
        avatarImageView.frame = CGRect(
            x: sideInset,
            y: topInset,
            width: avatarSize,
            height: avatarSize
        )
        avatarImageView.layer.cornerRadius = avatarSize / 2

        // Имя
        let labelLeftX = avatarImageView.frame.maxX + 27
        fullNameLabel.frame = CGRect(
            x: labelLeftX,
            y: avatarImageView.frame.minY + 16,
            width: bounds.width - labelLeftX - sideInset,
            height: 22
        )

        // Серый статус текст над полем
        statusLabel.frame = CGRect(
            x: labelLeftX,
            y: fullNameLabel.frame.maxY + 8,
            width: bounds.width - labelLeftX - sideInset,
            height: 20
        )

        // Поле ввода статуса
        // В макете поле ~40pt высотой, скругление 12pt
        let textFieldTop = statusLabel.frame.maxY + 8
        statusTextField.frame = CGRect(
            x: labelLeftX,
            y: textFieldTop,
            width: bounds.width - labelLeftX - sideInset,
            height: 40
        )

        // Кнопка Set status
        let buttonTopY = max(avatarImageView.frame.maxY, statusTextField.frame.maxY) + 24
        let buttonHeight: CGFloat = 50
        actionButton.frame = CGRect(
            x: sideInset,
            y: buttonTopY,
            width: bounds.width - sideInset * 2,
            height: buttonHeight
        )
    }


    // MARK: - Actions

    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }

    @objc private func buttonPressed() {
        // При нажатии:
        // 1. записываем введённый текст как статус (меняем серый лейбл)
        // 2. логируем в консоль
        if !statusText.isEmpty {
            statusLabel.text = statusText
        }
        print("Статус установлен: \(statusLabel.text ?? "<пусто>")")
    }
}

