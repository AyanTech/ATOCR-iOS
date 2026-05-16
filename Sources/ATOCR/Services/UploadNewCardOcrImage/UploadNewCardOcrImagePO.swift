//
//  UploadNewCardOcrImagePO.swift
//  ATOCR
//
//  Created by Amir on 5/5/26.
//

import AyanTechNetworkingLibrary
import Foundation

public protocol UploadNewCardOcrImagePO: AnyObject {
    var userBasketAddBillsRequest: ATRequest? { get set }
    var userBasketAddBillsResponse: UploadNewCardOcrImageResponse? { get set }
    var userBasketAddBillsChangeHandler: ((OCRChangeHandler) -> Void)? { get set }
    
    func userBasketAddBills(url: String, input: UploadNewCardOcrImageInput, token: String)
}

public extension UploadNewCardOcrImagePO {
    func userBasketAddBills(url: String, input: UploadNewCardOcrImageInput, token: String) {
        emit(.isLoading(userBasketAddBillsRequest, true))
        userBasketAddBillsRequest = AppNetwork.shared.post(url: url,
                                                           input: input,
                                                           token: token,
                                                           completionHandler: ({ (response: UploadNewCardOcrImageResponse?,
                                                                                  error: ATPError?) in
            self.emit(.isLoading(self.userBasketAddBillsRequest, false, completion: {
                if let error {
                    self.emit(.didError(error))
                } else {
                    self.userBasketAddBillsResponse = response
                    self.emit(.didSuccess)
                }
            }))
        }))
    }
    
    func emit(_ change: OCRChangeHandler) {
        userBasketAddBillsChangeHandler?(change)
    }
}
