import UIKit

final class FeedViewController: UIViewController {

    private let model = FeedModel(secretWord: "swift")

    // MARK: - UI

    private let guessTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Введите слово…"
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Check guess")
        button.setOnTap { [weak self] in
            self?.checkGuess()
        }
        return button
    }()

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите слово и нажмите кнопку"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.backgroundColor = .systemBackground

        setupViews()
        setupConstraints()
    }

    // MARK: - Setup

    private func setupViews() {
        view.addSubview(guessTextField)
        view.addSubview(checkGuessButton)
        view.addSubview(resultLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            guessTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            guessTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            guessTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            guessTextField.heightAnchor.constraint(equalToConstant: 44),

            checkGuessButton.topAnchor.constraint(equalTo: guessTextField.bottomAnchor, constant: 12),
            checkGuessButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            checkGuessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 50),

            resultLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 16),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    // MARK: - Logic

    private func checkGuess() {
        let text = (guessTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

        guard !text.isEmpty else {
            showAlert(title: "Пустое значение", message: "Введите слово для проверки.")
            return
        }

        model.check(word: text) { [weak self] isCorrect in
            guard let self else { return }

            if isCorrect {
                self.resultLabel.text = "Верно ✅"
                self.resultLabel.textColor = .systemGreen
            } else {
                self.resultLabel.text = "Неверно ❌"
                self.resultLabel.textColor = .systemRed
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

