//
//  GetCardOcrResultPO.swift
//  ATOCR
//
//  Created by Amir on 5/5/26.
//

import AyanTechNetworkingLibrary
import Foundation

protocol GetCardOcrResultPO: AnyObject {
    var getCardOcrResultRequest: ATRequest? { get set }
    var getCardOcrResultResponse: GetCardOcrResultResponse? { get set }
    var getCardOcrResultChangeHandler: ((OCRChangeHandler) -> Void)? { get set }
    
    func getCardOcrResult(url: String, input: UploadNewCardOcrImageInput)
}

extension GetCardOcrResultPO {
    func getCardOcrResult(url: String, input: UploadNewCardOcrImageInput) {
        emit(.isLoading(getCardOcrResultRequest, true))
        getCardOcrResultRequest = AppNetwork.shared.post(url: url,
                                                         input: input,
                                                         completionHandler: ({ (response: GetCardOcrResultResponse?,
                                                                                error: ATPError?) in
            self.emit(.isLoading(self.getCardOcrResultRequest, false, completion: {
                if let error {
                    self.emit(.didError(error))
                } else {
                    if response?.retryable ?? false {
                        DispatchQueue.main.asyncAfter(deadline: .now() + (response?.nextCallInterval ?? 0)) {
                            self.getCardOcrResult(url: url, input: input)
                        }
                    } else {
                        self.getCardOcrResultResponse = response
                        self.emit(.didSuccess)
                    }
                }
            }))
        }))
    }
    
    func emit(_ change: OCRChangeHandler) {
        getCardOcrResultChangeHandler?(change)
    }
}
