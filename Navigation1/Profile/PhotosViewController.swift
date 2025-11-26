//
//  PhotosViewController.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 26.11.2025.
//
import UIKit

final class PhotosViewController: UIViewController {

    // MARK: - Data

    private let photoNames: [String]

    // MARK: - UI

    private let collectionView: UICollectionView

    // MARK: - Init

    init(photoNames: [String]) {
        self.photoNames = photoNames

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Photo Gallery"
        view.backgroundColor = .systemBackground

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            PhotosCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}

// MARK: - UICollectionViewDataSource

extension PhotosViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        photoNames.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotosCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? PhotosCollectionViewCell else {
            return UICollectionViewCell()
        }

        let imageName = photoNames[indexPath.item]
        cell.configure(with: imageName)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {

    // Отступы секции (подгони под макет — здесь 12 по бокам, 12 сверху/снизу)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        8
    }

    // 3 равные ячейки в ряд
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let insets = self.collectionView(
            collectionView,
            layout: collectionViewLayout,
            insetForSectionAt: indexPath.section
        )
        let spacing = self.collectionView(
            collectionView,
            layout: collectionViewLayout,
            minimumInteritemSpacingForSectionAt: indexPath.section
        )

        let totalHorizontalInset = insets.left + insets.right
        let totalSpacing = spacing * 2          // 3 колонки → 2 промежутка
        let width = collectionView.bounds.width - totalHorizontalInset - totalSpacing
        let itemWidth = floor(width / 3)

        return CGSize(width: itemWidth, height: itemWidth)
    }
}

