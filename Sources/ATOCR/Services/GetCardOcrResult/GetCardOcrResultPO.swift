//
//  GetCardOcrResultPO.swift
//  ATOCR
//
//  Created by Amir on 5/5/26.
//

import AyanTechNetworkingLibrary
import Foundation

@MainActor
public protocol GetCardOcrResultPO: AnyObject {
    var getCardOcrResultRequest: ATRequest? { get set }
    var getCardOcrResultResponse: OCRResult? { get set }
    var getCardOcrResultChangeHandler: ((OCRChangeHandler) -> Void)? { get set }
    
    func getCardOcrResult(url: String,
                          input: GetCardOcrResultInput,
                          token: String)
}

@MainActor
public extension GetCardOcrResultPO {
    func getCardOcrResult(url: String,
                          input: GetCardOcrResultInput,
                          token: String) {
        emit(.isLoading(getCardOcrResultRequest, true))
        
        getCardOcrResultRequest = AppNetwork.shared.post(url: url,
                                                         input: input,
                                                         token: token,
                                                         completionHandler: { [weak self] (response: GetCardOcrResultResponse?,
                                                                                           error: Error?) in
            
            guard let self else { return }
            if let error = error as? OCRAppNetworkError {
                self.handleError(
                    error.message,
                    isUnauthorized: false
                )
                return
            }
            
            guard let response else {
                self.handleError("خطا در دریافت اطلاعات",
                                 isUnauthorized: false)
                return
            }
            
            self.handleResponse(response,
                                url: url,
                                input: input,
                                token: token)
        }
        )
    }
    
    // MARK: - Response Handling
    
    private func handleResponse(_ response: GetCardOcrResultResponse,
                                url: String,
                                input: GetCardOcrResultInput,
                                token: String) {
        switch response.status.lowercased() {
        case "failed":
            handleError(
                response.description ?? "خطا در دریافت اطلاعات",
                isUnauthorized: false
            )
            
        case "pending":
            guard let nextCallInterval = response.nextCallInterval else {
                handleError("خطا در دریافت اطلاعات", isUnauthorized: false)
                return
            }
            retryGetCardOcrResult(after: Int(nextCallInterval),
                                  url: url,
                                  input: input,
                                  token: token)
            
        default:
            handleSuccess(
                response
            )
        }
    }
    
    // MARK: - Retry
    
    private func retryGetCardOcrResult(after interval: Int?,
                                       url: String,
                                       input: GetCardOcrResultInput,
                                       token: String) {
        let delay = Double(interval ?? 0) / 1000.0
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + delay
        ) { [weak self] in
            
            guard let self else { return }
            
            self.getCardOcrResult(
                url: url,
                input: input,
                token: token
            )
        }
    }
    
    // MARK: - Success
    private func handleSuccess(_ response: GetCardOcrResultResponse) {
        emit(.isLoading(getCardOcrResultRequest, false))
        getCardOcrResultResponse = response.result
        emit(.didSuccess)
    }
    
    // MARK: - Error
    
    private func handleError(_ message: String, isUnauthorized: Bool) {
        emit(.isLoading(getCardOcrResultRequest, false))
        if isUnauthorized {
            emit(.didUnauthorized)
        } else {
            emit(.didError(message))
        }
    }
    
    // MARK: - Event
    
    func emit(_ change: OCRChangeHandler) {
        getCardOcrResultChangeHandler?(change)
    }
}
