//
//  LogInViewController.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 16.11.2025.
//

import UIKit

final class LogInViewController: UIViewController {

    // MARK: - UI

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alwaysBounceVertical = true
        return sv
    }()

    private let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Logo") // Logo.png в ассетах
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let formContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray6
        v.layer.cornerRadius = 10
        v.layer.masksToBounds = true
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.systemGray4.cgColor
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email or phone"
        tf.font = .systemFont(ofSize: 16)
        tf.borderStyle = .none
        tf.autocapitalizationType = .none
        tf.keyboardType = .emailAddress
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.font = .systemFont(ofSize: 16)
        tf.borderStyle = .none
        tf.isSecureTextEntry = true                     // 🔒 скрываем ввод
        tf.autocapitalizationType = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let separatorView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray4
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private lazy var logInButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Log In", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)

        // фон по макету: синий пиксель
        if let bg = UIImage(named: "blue_pixel") {
            b.setBackgroundImage(bg.resizableImage(withCapInsets: .zero, resizingMode: .stretch),
                                 for: .normal)
        } else if let color = UIColor(named: "VKBlue") {
            b.backgroundColor = color
        } else {
            b.backgroundColor = .systemBlue
        }

        b.layer.cornerRadius = 10
        b.layer.masksToBounds = true

        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(handleLoginTap), for: .touchUpInside)
        return b
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Profile"

        setupNavigationBar()
        setupHierarchy()
        setupConstraints()
        setupGesture()
        setupKeyboardObservers()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Setup

    private func setupNavigationBar() {
        // Скрываем навбар ТОЛЬКО на этом экране
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    private func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(logoImageView)
        contentView.addSubview(formContainerView)
        formContainerView.addSubview(emailTextField)
        formContainerView.addSubview(separatorView)
        formContainerView.addSubview(passwordTextField)
        contentView.addSubview(logInButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // scrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // contentView
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // logo
            logoImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),

            // formContainer
            formContainerView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 80),
            formContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            formContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            formContainerView.heightAnchor.constraint(equalToConstant: 100),

            // email
            emailTextField.topAnchor.constraint(equalTo: formContainerView.topAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor, constant: 12),
            emailTextField.trailingAnchor.constraint(equalTo: formContainerView.trailingAnchor, constant: -12),
            emailTextField.heightAnchor.constraint(equalTo: formContainerView.heightAnchor, multiplier: 0.5),

            // separator
            separatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: formContainerView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),

            // password
            passwordTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor, constant: 12),
            passwordTextField.trailingAnchor.constraint(equalTo: formContainerView.trailingAnchor, constant: -12),
            passwordTextField.bottomAnchor.constraint(equalTo: formContainerView.bottomAnchor),

            // logInButton
            logInButton.topAnchor.constraint(equalTo: formContainerView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTapToDismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    // MARK: - Keyboard

    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        else { return }

        let keyboardHeight = frame.height - view.safeAreaInsets.bottom
        scrollView.contentInset.bottom = keyboardHeight
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }

    // MARK: - Actions

    @objc private func handleTapToDismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func handleLoginTap() {
        // По заданию: независимо от данных — переходим на экран профиля
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
}
