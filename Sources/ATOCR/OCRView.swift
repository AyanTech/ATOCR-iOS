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
        didSet {
            titleLabel.text = title
        }
    }
    
    public var titleFont: UIFont = .systemFont(
        ofSize: 18,
        weight: .semibold
    ) {
        didSet {
            titleLabel.font = titleFont
        }
    }
    
    public var titleColor: UIColor = .label {
        didSet {
            titleLabel.textColor = titleColor
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(
            .required,
            for: .vertical
        )
        label.setContentHuggingPriority(
            .required,
            for: .vertical
        )
        label.text = title
        label.font = titleFont
        label.textColor = titleColor
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
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
    
    convenience init(
        title: String,
        titleFont: UIFont = .systemFont(
            ofSize: 18,
            weight: .semibold
        ),
        titleColor: UIColor = .label
    ) {
        self.init(frame: .zero)
        
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor
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
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

public extension OCRView {
    func setItems(_ items: [OCRCollectionItem]) {
        self.items = items
        collectionView.reloadData()
    }
}

extension OCRView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
        return items.count
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
