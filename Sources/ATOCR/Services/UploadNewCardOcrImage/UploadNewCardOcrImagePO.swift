//
//  UploadNewCardOcrImagePO.swift
//  ATOCR
//
//  Created by Amir on 5/5/26.
//

import AyanTechNetworkingLibrary
import Foundation

public protocol UploadNewCardOcrImagePO: AnyObject {
    var uploadNewCardOcrImageRequest: ATRequest? { get set }
    var uploadNewCardOcrImageInput: UploadNewCardOcrImageInput? { get set }
    var uploadNewCardOcrImageResponse: UploadNewCardOcrImageResponse? { get set }
    var uploadNewCardOcrImageChangeHandler: ((OCRChangeHandler) -> Void)? { get set }
    
    func uploadNewCardOcrImage(url: String, input: UploadNewCardOcrImageInput, token: String)
}

public extension UploadNewCardOcrImagePO {
    func uploadNewCardOcrImage(url: String, input: UploadNewCardOcrImageInput, token: String) {
        emit(.isLoading(uploadNewCardOcrImageRequest, true))
        uploadNewCardOcrImageRequest = AppNetwork.shared.post(url: url,
                                                              input: input,
                                                              token: token,
                                                              completionHandler: ({ (response: UploadNewCardOcrImageResponse?,
                                                                                     error: ATPError?) in
            self.emit(.isLoading(self.uploadNewCardOcrImageRequest, false))
            if let error {
                self.emit(.didError(error.persianDescription ?? "خطا در دریافت اطلاعات"))
            } else {
                self.uploadNewCardOcrImageResponse = response
                self.emit(.didSuccess)
            }
        }))
    }
    
    func emit(_ change: OCRChangeHandler) {
        uploadNewCardOcrImageChangeHandler?(change)
    }
}
