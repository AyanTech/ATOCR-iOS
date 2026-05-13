//
//  OCRView.swift
//  ATOCR
//
//  Created by Amir on 5/13/26.
//

import UIKit

public final class OCRView: UIView {
    
    private var items: [CollectionItem] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 12
        
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        
        view.register(
            OCRCollectionViewCell.self,
            forCellWithReuseIdentifier: OCRCollectionViewCell.identifier
        )
        
        return view
    }()
    
    // MARK: - Init
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension OCRView {
    
    func setItems(_ items: [CollectionItem]) {
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
    
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        items.count
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OCRCollectionViewCell.identifier,
            for: indexPath
        ) as? OCRCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = items[indexPath.item]
        cell.configure(
            title: item.title,
            image: item.image
        )
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension OCRView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let width = (
            collectionView.bounds.width - 64
        ) / 4
        
        return CGSize(
            width: width,
            height: width
        )
    }
}

