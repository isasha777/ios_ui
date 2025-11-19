import UIKit

final class ProfileHeaderView: UIView {

    private var statusText: String = ""

    private let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "avatar") ?? UIImage(systemName: "person.circle.fill")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.layer.borderWidth = 3
        iv.layer.borderColor = UIColor.white.cgColor
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let fullNameLabel: UILabel = {
        let l = UILabel()
        l.text = "Hipster Cat"
        l.font = .systemFont(ofSize: 18, weight: .bold)
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let statusLabel: UILabel = {
        let l = UILabel()
        l.text = "Waiting for something..."
        l.font = .systemFont(ofSize: 14)
        l.textColor = .gray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var statusTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Set your status..."
        tf.font = .systemFont(ofSize: 15)
        tf.textColor = .black
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.masksToBounds = true
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        tf.leftViewMode = .always
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        return tf
    }()

    private lazy var setStatusButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Set status", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .systemBlue
        b.layer.cornerRadius = 10
        b.layer.masksToBounds = false
        b.layer.shadowColor = UIColor.black.cgColor
        b.layer.shadowOpacity = 0.7
        b.layer.shadowOffset = CGSize(width: 4, height: 4)
        b.layer.shadowRadius = 4
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(didTapSetStatus), for: .touchUpInside)
        return b
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
    }

    private func setupSubviews() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // avatar
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),

            // name
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 27),
            fullNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            // gray status
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            // text field
            statusTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusTextField.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),

            // button
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
    }

    // MARK: - Actions

    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }

    @objc private func didTapSetStatus() {
        if !statusText.isEmpty {
            statusLabel.text = statusText
        }
        print("Статус: \(statusLabel.text ?? "")")
        endEditing(true)
    }
}

