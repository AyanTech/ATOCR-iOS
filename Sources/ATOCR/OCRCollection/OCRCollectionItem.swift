//
//  OCRCollectionItem.swift
//  ATOCR
//
//  Created by Amir on 5/13/26.
//

import UIKit

public struct OCRCollectionItem {
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
