//
//  UploadNewCardOcrImagePO.swift
//  ATOCR
//
//  Created by Amir on 5/5/26.
//

import AyanTechNetworkingLibrary
import Foundation

@MainActor
public protocol UploadNewCardOcrImagePO: AnyObject {
    var uploadNewCardOcrImageRequest: ATRequest? { get set }
    var uploadNewCardOcrImageInput: UploadNewCardOcrImageInput? { get set }
    var uploadNewCardOcrImageResponse: UploadNewCardOcrImageResponse? { get set }
    var uploadNewCardOcrImageChangeHandler: ((OCRChangeHandler) -> Void)? { get set }
    
    func uploadNewCardOcrImage(url: String,
                               input: UploadNewCardOcrImageInput,
                               token: String)
}

@MainActor
public extension UploadNewCardOcrImagePO {
    func uploadNewCardOcrImage(url: String,
                               input: UploadNewCardOcrImageInput,
                               token: String) {
        emit(.isLoading(uploadNewCardOcrImageRequest, true))
        uploadNewCardOcrImageRequest = AppNetwork.shared.post(url: url,
                                                              input: input,
                                                              token: token,
                                                              completionHandler: { [weak self] (response: UploadNewCardOcrImageResponse?,
                                                                                                error: Error?) in
            
            guard let self else { return }
            
            if let error {
                self.handleError(error.localizedDescription)
                return
            }
            
            guard let response else {
                self.handleError("خطا در دریافت اطلاعات")
                return
            }
            
            self.handleSuccess(response)
        }
        )
    }
    
    // MARK: - Success
    private func handleSuccess(_ response: UploadNewCardOcrImageResponse) {
        emit(.isLoading(uploadNewCardOcrImageRequest, false))
        uploadNewCardOcrImageResponse = response
        emit(.didSuccess)
    }
    
    // MARK: - Error
    private func handleError(_ message: String) {
        emit(.isLoading(uploadNewCardOcrImageRequest, false))
        emit(.didError(message))
    }
    
    // MARK: - Event
    
    func emit(_ change: OCRChangeHandler) {
        uploadNewCardOcrImageChangeHandler?(change)
    }
}
