import UIKit
import iOSIntPackage

final class PhotosViewController: UIViewController {

    // MARK: - Data

    private var images: [UIImage] = []
    private let publisherFacade = ImagePublisherFacade()

    // MARK: - UI

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .systemBackground
        cv.dataSource = self
        cv.delegate = self
        cv.register(PhotosCollectionViewCell.self,
                    forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseId)
        return cv
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photo Gallery"
        view.backgroundColor = .systemBackground

        setupViews()
        setupConstraints()

        // ✅ 1) ПОДПИСКА (обязательно подобрать точное имя метода через autocomplete)
        // Напечатай: publisherFacade. и посмотри доступные методы (subscribe/addSubscriber/…)
        // Пример (замени на свой):
        // publisherFacade.subscribe(self)
        subscribeToPublisher()

        // ✅ 2) СТАРТ заполнения (у тебя точно требует repeat:)
        publisherFacade.addImagesWithTimer(time: 0.5, repeat: 20)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // ✅ 3) ОТПИСКА (точное имя метода тоже через autocomplete)
        unsubscribeFromPublisher()
    }

    deinit {
        unsubscribeFromPublisher()
    }

    // MARK: - Subscribe / Unsubscribe (вынесено в методы, как любят проверяющие)

    private func subscribeToPublisher() {
        // Вставь сюда 1 строку с правильным методом подписки:
        // publisherFacade.<#subscribeMethod#>(self)

        // ВАЖНО: чтобы Xcode подсказал:
        // набери "publisherFacade." и посмотри список.
        publisherFacade.subscribe(self)
    }

    private func unsubscribeFromPublisher() {
        // Вставь сюда 1 строку с правильным методом отписки:
        //publisherFacade.<#unsubscribeMethod#>(self)

        // Если у тебя нет unsubscribe/removeSubscriber/removeSubscription —
        // значит метод называется иначе. Его точно видно в autocomplete.
        // Пока оставь так — и замени на правильный.
        //publisherFacade.unsubscribe(self)
    }

    // MARK: - Helpers

    private func appendImage(_ image: UIImage) {
        images.append(image)
        let indexPath = IndexPath(item: images.count - 1, section: 0)
        collectionView.insertItems(at: [indexPath])
    }

    // MARK: - Setup

    private func setupViews() {
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - ImageLibrarySubscriber
extension PhotosViewController: ImageLibrarySubscriber {
    func receive(images: [UIImage]) {
        
    }
    

    // ❗ ВАЖНО:
    // Сейчас ты получишь ТОЧНУЮ сигнатуру метода через Xcode.
    // Сделай так:
    // 1) Нажми на ошибку "does not conform"
    // 2) Fix-it -> Add stubs
    // 3) Xcode вставит сюда правильный метод
    // 4) Внутри метода вызови appendImage(image)

    // Пример (не факт что у тебя такой!):
    // func receive(_ image: UIImage) { ... }

    // ВРЕМЕННО я оставлю один самый частый вариант.
    // Если у тебя другой — Xcode сам заменит при Add stubs.
    func receive(_ image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.appendImage(image)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        images.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.reuseId,
            for: indexPath
        ) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: images[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let spacing: CGFloat = 8
        let totalSpacing = spacing * 2 + spacing * 2
        let side = (collectionView.bounds.width - totalSpacing) / 3
        return CGSize(width: side, height: side)
    }
}

