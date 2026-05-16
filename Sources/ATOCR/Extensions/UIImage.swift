//
//  ImageExtensions.swift
//  ATOCR
//
//  Created by Amir on 4/27/26.
//
import UIKit

extension UIImage {
    func compressedData(maxSizeMB: Double,
                        minCompression: CGFloat = 0.1 ,
                        resizeStep: CGFloat = 0.9) -> Data? {
        let maxBytes = Int(maxSizeMB * 1024 * 1024)
        var compression: CGFloat = resizeStep
        guard var imageData = self.jpegData(compressionQuality: compression) else { return nil }
        
        while imageData.count > maxBytes && compression > minCompression {
            compression -= 0.1
            if let newData = self.jpegData(compressionQuality: compression) {
                imageData = newData
            } else {
                break
            }
        }
        if imageData.count > maxBytes {
            var resizedImage = self
            while imageData.count > maxBytes {
                let scale: CGFloat = 0.8 // reduce each time by 20%
                let newSize = CGSize(width: resizedImage.size.width * scale,
                                     height: resizedImage.size.height * scale)
                
                UIGraphicsBeginImageContextWithOptions(newSize, false, resizedImage.scale)
                resizedImage.draw(in: CGRect(origin: .zero, size: newSize))
                let newImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                
                guard let img = newImage,
                      let newData = img.jpegData(compressionQuality: compression)
                else { break }
                
                resizedImage = img
                imageData = newData
            }
        }
        return imageData
    }
}
