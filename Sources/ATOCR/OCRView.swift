//
//  OCRView.swift
//  ATOCR
//
//  Created by Amir on 5/13/26.
//

import UIKit

public protocol OCRViewDelegate: AnyObject {
    func ocrViewDidSelectItem(_ item: OCRCollectionItem)
}

public final class OCRView: UIView {

    public weak var delegate: OCRViewDelegate?

    private var items: [OCRCollectionItem] = []

    public var title: String = "" {
        didSet { titleLabel.text = title }
    }

    public var titleFont: UIFont = .systemFont(ofSize: 18, weight: .semibold) {
        didSet { titleLabel.font = titleFont }
    }

    public var titleColor: UIColor = .label {
        didSet { titleLabel.textColor = titleColor }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false

        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)

        label.text = title
        label.font = titleFont
        label.textColor = titleColor

        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear

        view.dataSource = self
        view.delegate = self

        view.register(
            OCRCollectionViewCell.self,
            forCellWithReuseIdentifier: OCRCollectionViewCell.nameOfClass
        )

        return view
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {

        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            collectionView
        ])

        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)
        ])
    }

    public func setItems(_ items: [OCRCollectionItem]) {
        self.items = items
        collectionView.reloadData()
    }
}

extension OCRView: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OCRCollectionViewCell.nameOfClass,
            for: indexPath
        ) as? OCRCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.config(data: items[indexPath.item])
        return cell
    }
}

extension OCRView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.ocrViewDidSelectItem(items[indexPath.item])
    }

    public func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemsPerRow: CGFloat = 4
        let spacing: CGFloat = 8

        let totalSpacing = (itemsPerRow - 1) * spacing

        let width = (collectionView.bounds.width - totalSpacing) / itemsPerRow

        return CGSize(width: width, height: width + 24)
    }
}
