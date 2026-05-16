//
//  OCRCollectionViewCell.swift
//  ATOCR
//
//  Created by Amir on 5/13/26.
//

import UIKit

class OCRCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func config(data: OCRCollectionItem) {
        self.titleLabel.text = data.title
        self.titleLabel.textColor = data.titleColor
        self.titleLabel.font = data.titleFont
        self.titleLabel.textAlignment = .center
        self.imageView.layer.cornerRadius = 16
        self.imageView.image = data.image ?? UIImage(named: "ocr_camera")
        self.checkmarkImage.isHidden = data.image == nil
        self.containerView.layer.sublayers?.removeAll(where: { $0.name == "dashedBorderLayer" })
        let dashedLayer = CAShapeLayer()
        dashedLayer.name = "dashedBorderLayer"
        containerView.addDashedBorder(shapeLayer: dashedLayer,
                                      color: data.borderColor,
                                      cornerRadius: data.borderRadius,
                                      linePattern: [4, 4],
                                      addSubView: true)
    }
}

extension UICollectionViewCell {
    class func register(for collectionView: UICollectionView) {
        collectionView.register(
            UINib(nibName: self.nameOfClass, bundle: .module),
            forCellWithReuseIdentifier: self.nameOfClass
        )
    }
}

extension NSObject {
    @objc static var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}


extension UIView {
    func addDashedBorder(shapeLayer: CAShapeLayer = CAShapeLayer(),
                         color: UIColor,
                         lineWidth: CGFloat = 1,
                         cornerRadius: CGFloat = 8,
                         linePattern: [NSNumber]? = [5, 5],
                         addSubView: Bool = false) {
        let shapeRect = CGRect(origin: .zero, size: self.bounds.size)
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: self.bounds.width / 2,
                                      y: self.bounds.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = linePattern
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect,
                                       cornerRadius: cornerRadius).cgPath
        if addSubView {
            self.layer.addSublayer(shapeLayer)
        }
    }
}
