//
//  PostTableViewCell.swift
//  Navigation1
//
//  Created by Alex Nekrasow on 18.11.2025.
//

import UIKit

final class PostTableViewCell: UITableViewCell {

    static let reuseIdentifier = "PostTableViewCell"

    private let authorLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 20, weight: .bold)
        l.textColor = .black
        l.numberOfLines = 1
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let descriptionLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14)
        l.textColor = .darkGray
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let likesLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = .black
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private let viewsLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 14, weight: .regular)
        l.textColor = .black
        l.textAlignment = .right
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupSubviews() {
        contentView.addSubview(authorLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
    }

    private func setupConstraints() {
        let inset: CGFloat = 16

        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])

        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.heightAnchor.constraint(equalTo: postImageView.widthAnchor, multiplier: 0.75) // примерно 4:3
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset)
        ])

        NSLayoutConstraint.activate([
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])

        NSLayoutConstraint.activate([
            viewsLabel.centerYAnchor.constraint(equalTo: likesLabel.centerYAnchor),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            viewsLabel.leadingAnchor.constraint(greaterThanOrEqualTo: likesLabel.trailingAnchor, constant: 8)
        ])
    }

    // MARK: - Configure

    func configure(with post: Post) {
        authorLabel.text = post.author
        descriptionLabel.text = post.description
        postImageView.image = UIImage(named: post.image)
        likesLabel.text = "Likes: \(post.likes)"
        viewsLabel.text = "Views: \(post.views)"
    }
}
