//
//  OCRCollectionItem.swift
//  ATOCR
//
//  Created by Amir on 5/13/26.
//

import UIKit

public struct OCRCollectionItem {
    public let guid: String
    public let title: String
    public let titleColor: UIColor
    public let titleFont: UIFont
    public let borderColor: UIColor
    public let borderRadius: CGFloat
    public var image: UIImage?
    
    public init(title: String,
                titleColor: UIColor,
                titleFont: UIFont,
                borderColor: UIColor,
                borderRadius: CGFloat,
                image: UIImage?) {
        self.guid = UUID().uuidString
        self.title = title
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.borderColor = borderColor
        self.borderRadius = borderRadius
        self.image = image
    }
}
