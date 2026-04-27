//
//  ATOCRImageCompressor.swift
//  ATOCR
//
//  Created by Amir on 4/27/26.
//
import Foundation
import UIKit

public struct ATOCRImageCompressor {
    public struct Config {
        public let maxSizeMB: Double
        public let minQuality: CGFloat
        public let resizeStep: CGFloat

        public init(
            maxSizeMB: Double = 6.0,
            minQuality: CGFloat = 0.1,
            resizeStep: CGFloat = 0.8
        ) {
            self.maxSizeMB = maxSizeMB
            self.minQuality = minQuality
            self.resizeStep = resizeStep
        }
    }

    private let config: Config

    public init(config: Config = Config()) {
        self.config = config
    }

    public func compress(_ image: UIImage) -> Data? {
        return image.compressedData(to: config.maxSizeMB)
    }
    
    public func compressBase64(_ image: UIImage) -> String? {
        let data = image.compressedData(to: config.maxSizeMB)
        return data?.base64EncodedString()
    }
}
