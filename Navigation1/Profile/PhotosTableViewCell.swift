//
//  PhotosTableViewCell.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 26.11.2025.
//

import UIKit

final class PhotosTableViewCell: UITableViewCell {

    static let reuseIdentifier = "PhotosTableViewCell"

    // MARK: - UI

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let photosStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var photoImageViews: [UIImageView] = []

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupViews() {
        selectionStyle = .default
        contentView.backgroundColor = .white

        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(photosStackView)

        // создаём 4 imageView для превью
        for _ in 0..<4 {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 6
            imageView.translatesAutoresizingMaskIntoConstraints = false
            photosStackView.addArrangedSubview(imageView)
            photoImageViews.append(imageView)
        }
    }

    private func setupConstraints() {
        let inset: CGFloat = 12

        NSLayoutConstraint.activate([
            // Заголовок
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),

            // Стрелка
            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            arrowImageView.widthAnchor.constraint(equalToConstant: 16),
            arrowImageView.heightAnchor.constraint(equalToConstant: 16),
            arrowImageView.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8),

            // Стек с фото
            photosStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            photosStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            photosStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            photosStackView.heightAnchor.constraint(equalToConstant: 80),
            photosStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }

    // MARK: - Configure

    /// Передаём массив имён изображений; в ячейке показываются только первые 4
    func configure(with imageNames: [String]) {
        for (index, imageView) in photoImageViews.enumerated() {
            if index < imageNames.count {
                imageView.image = UIImage(named: imageNames[index])
            } else {
                imageView.image = nil
            }
        }
    }
}
