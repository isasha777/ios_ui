import UIKit
import iOSIntPackage

final class PhotosViewController: UIViewController {

    // MARK: - Data

    private var sourceImages: [UIImage] = []
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

        // Сначала показываем обычные фото без обработки
        displayedImages = sourceImages
        collectionView.reloadData()

        // Один активный пример обработки
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

        processImages(
            images: sourceImages,
            qos: QualityOfService.userInitiated,
            filter: ColorFilter.noir
        )

        /*
        processImages(
            images: sourceImages,
            qos: QualityOfService.utility,
            filter: ColorFilter.chrome
        )

        processImages(
            images: Array(sourceImages.prefix(6)),
            qos: QualityOfService.background,
            filter: ColorFilter.fade
        )
        */
    }

    private func processImages(
        images: [UIImage],
        qos: QualityOfService,
        filter: ColorFilter
    ) {
        let startTime = CFAbsoluteTimeGetCurrent()

        ImageProcessor().processImagesOnThread(
            sourceImages: images,
            filter: filter,
            qos: qos
        ) { [weak self] processedImages in
            guard let self else { return }

            let endTime = CFAbsoluteTimeGetCurrent()
            let elapsed = endTime - startTime

            print("qos: \(qos), images: \(images.count), filter: \(filter), time: \(elapsed) sec")

            let uiImages = processedImages.compactMap { cgImage -> UIImage? in
                guard let cgImage else { return nil }
                return UIImage(cgImage: cgImage)
            }

            DispatchQueue.main.async {
                self.displayedImages = uiImages
                self.collectionView.reloadData()
            }
        }

        /*
         Примеры комментариев для ДЗ после замеров:
         // userInitiated, 12 images, filter noir — 0.84 sec
         // utility, 12 images, filter chrome — 1.31 sec
         // background, 6 images, filter fade — 0.92 sec
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
