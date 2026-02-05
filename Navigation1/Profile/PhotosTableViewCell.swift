import UIKit
import StorageService

final class PhotosTableViewCell: UITableViewCell {

    static let reuseIdentifier = "PhotosTableViewCell"

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
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var photoImageViews: [UIImageView] = []

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .default
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(photosStackView)

        for _ in 0..<4 {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.layer.cornerRadius = 6
            iv.translatesAutoresizingMaskIntoConstraints = false
            photosStackView.addArrangedSubview(iv)
            photoImageViews.append(iv)
        }
    }

    private func setupConstraints() {
        let inset: CGFloat = 12

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),

            arrowImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            arrowImageView.widthAnchor.constraint(equalToConstant: 16),
            arrowImageView.heightAnchor.constraint(equalToConstant: 16),
            arrowImageView.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: 8),

            photosStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            photosStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            photosStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            photosStackView.heightAnchor.constraint(equalToConstant: 80),
            photosStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }

    // MARK: - Configure

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

