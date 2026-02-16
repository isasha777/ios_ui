import UIKit

final class LogInViewController: UIViewController {

    // MARK: - Dependencies

    private let userService: UserService
    var loginDelegate: LoginViewControllerDelegate?
    weak var coordinator: ProfileCoordinator?

    // MARK: - UI

    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Logo") // <-- проверь имя ассета
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let loginTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Login"
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private let logInButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Log In", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = UIColor(red: 0.28, green: 0.52, blue: 0.80, alpha: 1)
        b.layer.cornerRadius = 10
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()

    // MARK: - Init

    init(userService: UserService) {
        self.userService = userService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true

        setupViews()
        setupConstraints()

        logInButton.addTarget(self, action: #selector(logInTapped), for: .touchUpInside)
    }

    // MARK: - Setup

    private func setupViews() {
        view.addSubview(logoImageView)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Logo
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),

            // Login
            loginTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 80),
            loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginTextField.heightAnchor.constraint(equalToConstant: 44),

            // Password
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 12),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),

            // Button
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Actions

    @objc private func logInTapped() {
        let login = (loginTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text ?? ""

        guard let loginDelegate else {
            showAlert(title: "Ошибка", message: "Не настроен сервис проверки логина.")
            return
        }

        let isValid = loginDelegate.check(login: login, password: password)
        guard isValid else {
            showAlert(title: "Ошибка", message: "Неверный логин или пароль")
            return
        }

        guard let user = userService.getUser(login: login) else {
            showAlert(title: "Ошибка", message: "Пользователь не найден")
            return
        }

        let profileVC = ProfileViewController()
        profileVC.user = user
        coordinator?.showProfile(user: user)
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

