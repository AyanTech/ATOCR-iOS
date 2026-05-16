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

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = .init(
            top: 16,
            left: 16,
            bottom: 16,
            right: 16
        )

        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )

        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self

        OCRCollectionViewCell.register(for: view)

        return view
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension OCRView {

    func setItems(_ items: [OCRCollectionItem]) {
        self.items = items
        collectionView.reloadData()
    }
}

private extension OCRView {

    func setupUI() {
        addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension OCRView: UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OCRCollectionViewCell.nameOfClass,
                                                            for: indexPath) as? OCRCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.config(data: items[indexPath.item])

        return cell
    }
}

extension OCRView: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView,
                               didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        delegate?.ocrViewDidSelectItem(item)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemsPerRow: CGFloat = 4
        let spacing: CGFloat = 8
        let horizontalInset: CGFloat = 32

        let totalSpacing =
        ((itemsPerRow - 1) * spacing) + horizontalInset

        let width =
        (collectionView.bounds.width - totalSpacing)
        / itemsPerRow

        return CGSize(width: width, height: width + 24)
    }
}
