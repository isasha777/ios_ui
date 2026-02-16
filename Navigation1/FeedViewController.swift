import UIKit

final class FeedViewController: UIViewController {

    private let viewModel: FeedViewModel
    
    weak var coordinator: FeedCoordinator?

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
            self?.viewModel.didTapCheck(word: self?.guessTextField.text)
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

    // MARK: - Init

    init(viewModel: FeedViewModel = FeedViewModel(model: FeedModel(secretWord: "swift"))) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.backgroundColor = .systemBackground

        setupViews()
        setupConstraints()
        bindViewModel()
    }

    // MARK: - Binding

    private func bindViewModel() {
        viewModel.onResultTextChange = { [weak self] text in
            self?.resultLabel.text = text
        }

        viewModel.onResultColorChange = { [weak self] color in
            self?.resultLabel.textColor = color
        }

        viewModel.onShowAlert = { [weak self] title, message in
            self?.showAlert(title: title, message: message)
        }
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

    // MARK: - Alert

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

