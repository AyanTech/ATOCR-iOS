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
        public let minCompression: CGFloat
        public let resizeStep: CGFloat

        public init(
            maxSizeMB: Double = 6.0,
            minCompression: CGFloat = 0.1,
            resizeStep: CGFloat = 0.9
        ) {
            self.maxSizeMB = maxSizeMB
            self.minCompression = minCompression
            self.resizeStep = resizeStep
        }
    }

    private let config: Config

    public init(config: Config = Config()) {
        self.config = config
    }

    public func compress(_ image: UIImage) -> Data? {
        return image.compressedData(maxSizeMB: config.maxSizeMB,
                                    minCompression: config.minCompression,
                                    resizeStep: config.resizeStep)
    }
    
    public func compressBase64(_ image: UIImage) -> String? {
        let data = image.compressedData(maxSizeMB: config.maxSizeMB,
                                        minCompression: config.minCompression,
                                        resizeStep: config.resizeStep)
        return data?.base64EncodedString()
    }
}
