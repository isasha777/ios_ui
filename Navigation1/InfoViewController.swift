import UIKit

final class InfoViewController: UIViewController {

    private lazy var showAlertButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Показать алёрт"
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleShowAlertTap), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Инфо"
        view.backgroundColor = .systemBackground

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(handleCloseTap)
        )

        view.addSubview(showAlertButton)
        NSLayoutConstraint.activate([
            showAlertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showAlertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showAlertButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func handleCloseTap() {
        dismiss(animated: true)
    }

    @objc private func handleShowAlertTap() {
        let alert = UIAlertController(
            title: "Информация",
            message: "Это тестовое сообщение с двумя действиями.",
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("Нажали OK")
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { _ in
            print("Нажали Отмена")
        }

        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
}

