//
//  OCRCollectionViewCell.swift
//  ATOCR
//
//  Created by Amir on 5/13/26.
//

import UIKit

final class OCRCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DashedImageCollectionViewCell"
    
    // MARK: - Views
    
    private let imageContainerView = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    
    private let dashedLayer = CAShapeLayer()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateDashLayer()
    }
}

// MARK: - Public

extension OCRCollectionViewCell {
    
    func configure(
        title: String,
        titleFont: UIFont,
        titleColor: UIColor,
        image: UIImage?
    ) {
        titleLabel.text = title
        titleLabel.font = titleFont
        titleLabel.textColor = titleColor
        imageView.image = image
    }
}

// MARK: - Setup

private extension OCRCollectionViewCell {
    
    func setupUI() {
        contentView.backgroundColor = .clear
        
        imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        imageContainerView.layer.cornerRadius = 16
        imageContainerView.clipsToBounds = true
        
        contentView.addSubview(imageContainerView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        imageContainerView.addSubview(imageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            
            imageContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageContainerView.heightAnchor.constraint(equalTo: imageContainerView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor, constant: 16),
            imageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor, constant: -16),
            imageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    func updateDashLayer() {
        dashedLayer.removeFromSuperlayer()
        
        let path = UIBezierPath(
            roundedRect: imageContainerView.bounds,
            cornerRadius: 16
        )
        
        dashedLayer.path = path.cgPath
        dashedLayer.strokeColor = UIColor.systemGray3.cgColor
        dashedLayer.fillColor = UIColor.clear.cgColor
        dashedLayer.lineWidth = 1.5
        dashedLayer.lineDashPattern = [6, 4]
        
        imageContainerView.layer.addSublayer(dashedLayer)
    }
}

public struct CollectionItem {
    public let title: String
    public let titleColor: UIColor
    public let titleFont: UIFont
    public let image: UIImage?
    
    public init(
        title: String,
        titleColor: UIColor,
        titleFont: UIFont,
        image: UIImage?
    ) {
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.image = image
    }
}
