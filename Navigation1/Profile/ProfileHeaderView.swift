import UIKit

final class ProfileHeaderView: UIView {

    // MARK: - UI

    private let avatarImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "avatar") ?? UIImage(systemName: "person.circle.fill")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 50 // known size 100 → radius 50
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
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = .gray
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var statusTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter new status"
        tf.textColor = .black
        tf.font = .systemFont(ofSize: 15)
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 12
        tf.layer.masksToBounds = true
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.black.cgColor
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        tf.leftViewMode = .always
        tf.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        tf.translatesAutoresizingMaskIntoConstraints = false
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
        b.addTarget(self, action: #selector(handleSetStatus), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    // MARK: - State
    private var statusText: String = ""

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
        setupConstraints()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Constraints
    private func setupConstraints() {
        // Avatar 16/16, size 100
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100)
        ])

        // Name to the right of avatar (+27), top ~ +16 from avatar top
        NSLayoutConstraint.activate([
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 27),
            fullNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        // Gray status label under name (+8)
        NSLayoutConstraint.activate([
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
            statusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])

        // Text field under gray status (+8), height 40
        NSLayoutConstraint.activate([
            statusTextField.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
            statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])

        // Blue button full width (16/16), height 50
        // Top: ниже поля на 24, И НЕ МЕНЬШЕ чем avatar.bottom + 34
        let buttonTopFromText = setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 24)
        let buttonTopFromAvatar = setStatusButton.topAnchor.constraint(greaterThanOrEqualTo: avatarImageView.bottomAnchor, constant: 34)

        NSLayoutConstraint.activate([
            buttonTopFromText, buttonTopFromAvatar,
            setStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -16) // страховка, чтобы не вылезало
        ])
    }

    // MARK: - Actions
    @objc private func statusTextChanged(_ tf: UITextField) {
        statusText = tf.text ?? ""
    }

    @objc private func handleSetStatus() {
        if !statusText.isEmpty {
            statusLabel.text = statusText
        }
        print("Статус: \(statusLabel.text ?? "<empty>")")
        endEditing(true)
    }
}

