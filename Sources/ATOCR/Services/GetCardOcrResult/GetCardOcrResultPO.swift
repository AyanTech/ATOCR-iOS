//
//  GetCardOcrResultPO.swift
//  ATOCR
//
//  Created by Amir on 5/5/26.
//

import AyanTechNetworkingLibrary
import Foundation

public protocol GetCardOcrResultPO: AnyObject {
    var getCardOcrResultRequest: ATRequest? { get set }
    var getCardOcrResultResponse: GetCardOcrResultResponse? { get set }
    var getCardOcrResultChangeHandler: ((OCRChangeHandler) -> Void)? { get set }
    
    func getCardOcrResult(url: String, input: GetCardOcrResultInput, token: String)
}

@MainActor
public extension GetCardOcrResultPO {
    func getCardOcrResult(
        url: String,
        input: GetCardOcrResultInput,
        token: String
    ) {
        emit(.isLoading(getCardOcrResultRequest, true))
        
        getCardOcrResultRequest = AppNetwork.shared.post(
            url: url,
            input: input,
            token: token,
            completionHandler: { [weak self] (
                response: GetCardOcrResultResponse?,
                error: ATPError?
            ) in
                
                guard let self else { return }
                
                if let error {
                    self.emit(.isLoading(self.getCardOcrResultRequest, false))
                    self.emit(.didError(error.persianDescription ?? "خطا در دریافت اطلاعات"))
                    return
                }
                
                guard let response else {
                    self.emit(.isLoading(self.getCardOcrResultRequest, false))
                    self.emit(.didError("خطا در دریافت اطلاعات"))
                    return
                }
                
                switch response.status.lowercased() {
                case "failed":
                    self.emit(.isLoading(self.getCardOcrResultRequest, false))
                    self.emit(.didError(response.description ?? ""))
                    
                case "pending":
                    let delay = Double(response.nextCallInterval ?? 0) / 1000.0
                    DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                        self?.getCardOcrResult(url: url, input: input, token: token)
                    }
                    
                default:
                    self.emit(.isLoading(self.getCardOcrResultRequest, false))
                    self.getCardOcrResultResponse = response
                    self.emit(.didSuccess)
                }
            }
        )
    }
    
    func emit(_ change: OCRChangeHandler) {
        getCardOcrResultChangeHandler?(change)
    }
}
