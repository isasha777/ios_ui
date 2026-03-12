import UIKit
import iOSIntPackage

final class PhotosViewController: UIViewController {

    // MARK: - Data

    /// Исходные фото без обработки
    private var sourceImages: [UIImage] = []

    /// То, что показываем в коллекции
    private var displayedImages: [UIImage] = []

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
        cv.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseId
        )
        return cv
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Photo Gallery"
        view.backgroundColor = .systemBackground

        setupViews()
        setupConstraints()
        loadSourceImages()

        // Сначала показываем исходные фото
        displayedImages = sourceImages
        collectionView.reloadData()

        // Дальше можно поочерёдно вызывать разные варианты обработки.
        // Для отладки обычно оставляют один активный вызов, остальные — закомментированы.

        runProcessingExample()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
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

    // MARK: - Images

    private func loadSourceImages() {
        // Верни обычное заполнение фото, как было до Observer.
        // Подставь свои реальные имена ассетов.
        let names = [
            "photo_1", "photo_2", "photo_3",
            "photo_4", "photo_5", "photo_6",
            "photo_7", "photo_8", "photo_9",
            "photo_10", "photo_11", "photo_12"
        ]

        sourceImages = names.compactMap { UIImage(named: $0) }
    }

    // MARK: - Processing

    private func runProcessingExample() {
        guard !sourceImages.isEmpty else { return }

        // Пример №1
        processImages(
            images: sourceImages,
            qos: .userInitiated
            // filter: <выбери фильтр через автокомплит Xcode>
        )

        /*
        // Пример №2
        processImages(
            images: sourceImages,
            qos: .utility
            // filter: <другой фильтр>
        )

        // Пример №3
        processImages(
            images: Array(sourceImages.prefix(6)),
            qos: .background
            // filter: <ещё один фильтр>
        )
        */
    }

    private func processImages(
        images: [UIImage],
        qos: QualityOfService
        // filter: ImageProcessor.Filter
    ) {
        let startTime = CFAbsoluteTimeGetCurrent()

        /*
         ВАЖНО:
         У разных версий пакета сигнатура может немного отличаться.
         По заданию у тебя должен быть метод `processImagesOnThread`.

         После того как напишешь `ImageProcessor.` и выберешь автокомплит,
         подставь сюда точную сигнатуру из Xcode.

         Чаще всего это выглядит примерно так:
        */

        ImageProcessor().processImagesOnThread(
            sourceImages: images,
            qos: qos
            // filter: filter
        ) { [weak self] processedImages in
            guard let self else { return }

            let endTime = CFAbsoluteTimeGetCurrent()
            let elapsed = endTime - startTime

            print("qos: \(qos), images: \(images.count), time: \(elapsed) sec")

            DispatchQueue.main.async {
                self.displayedImages = processedImages
                self.collectionView.reloadData()
            }
        }

        /*
         Пример комментариев для ДЗ после замеров:
         // userInitiated, 12 images, filter X — 0.84 sec
         // utility, 12 images, filter X — 1.31 sec
         // background, 6 images, filter Y — 0.92 sec
        */
    }
}

// MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        displayedImages.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.reuseId,
            for: indexPath
        ) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: displayedImages[indexPath.item])
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
