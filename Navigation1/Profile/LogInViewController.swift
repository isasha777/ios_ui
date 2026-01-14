//
//  LogInViewController.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 16.11.2025.
//

import UIKit
import StorageService


final class LogInViewController: UIViewController {

    // MARK: - UI

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        // ВАЖНО: имя должно совпадать с imageset в Assets.xcassets
        iv.image = UIImage(named: "Logo")
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let formContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray6
        v.layer.cornerRadius = 10
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.lightGray.cgColor
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email or phone"
        tf.font = .systemFont(ofSize: 16)
        tf.autocapitalizationType = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let separatorView: UIView = {
        let v = UIView()
        v.backgroundColor = .lightGray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.font = .systemFont(ofSize: 16)
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let logInButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Log In", for: .normal)
        b.setTitleColor(.white, for: .normal)
        // картинка blue_pixel в ассетах (1×1), тянем как фон
        if let image = UIImage(named: "blue_pixel") {
            b.setBackgroundImage(image.resizableImage(withCapInsets: .zero, resizingMode: .stretch),
                                 for: .normal)
        } else {
            b.backgroundColor = UIColor(red: 0.28, green: 0.52, blue: 0.80, alpha: 1)
        }
        b.layer.cornerRadius = 10
        b.layer.masksToBounds = true
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true

        setupViews()
        setupConstraints()
        setupActions()
        setupKeyboardNotifications()
    }

    // MARK: - Setup

    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(logoImageView)
        contentView.addSubview(formContainerView)
        contentView.addSubview(logInButton)

        formContainerView.addSubview(emailTextField)
        formContainerView.addSubview(separatorView)
        formContainerView.addSubview(passwordTextField)
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

            // form container
            formContainerView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 80),
            formContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            formContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            formContainerView.heightAnchor.constraint(equalToConstant: 100),

            emailTextField.topAnchor.constraint(equalTo: formContainerView.topAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor, constant: 12),
            emailTextField.trailingAnchor.constraint(equalTo: formContainerView.trailingAnchor, constant: -12),
            emailTextField.heightAnchor.constraint(equalTo: formContainerView.heightAnchor, multiplier: 0.5),

            separatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: formContainerView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: formContainerView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),

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

    private func setupActions() {
        logInButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
    }

    private func setupKeyboardNotifications() {
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

    // MARK: - Actions

    @objc private func logInButtonPressed() {
        // без проверки данных — сразу в профиль
        let profileVC = ProfileViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }

        scrollView.contentInset.bottom = keyboardFrame.height + 20
        scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.height + 20
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets.bottom = .zero
    }
}
