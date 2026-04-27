//
//  AppNetwork.swift
//  ATOCR
//
//  Created by Amir on 4/27/26.
//
//
import Foundation
import AyanTechNetworkingLibrary
import SwiftBooster

public final class AppNetwork: @unchecked Sendable {

    public static let shared = AppNetwork()

    private init() {}
    
    fileprivate func post<O: Decodable>(url: String,
                                        tokenValidationRequired: Bool,
                                        body: Encodable?,
                                        parameterSelector: @escaping (ATResponse) -> Any?,
                                        completionHandler: @escaping (O?, ATPError?) -> Void) -> ATRequest {
        self.post(url: url, tokenValidationRequired: tokenValidationRequired, body: body) { response in
            if response.isSuccess {
                if response.parametersJsonArray == nil && response.parametersJsonObject == nil {
                    completionHandler(nil, nil)
                } else {
                    if let result = O(withJsonObject: parameterSelector(response)) {
                        completionHandler(result, nil)
                    } else {
                        var invalidDataError = ATPError()
                        invalidDataError.persianDescription = "مشکل در خواندن اطلاعات از سرور"
                        completionHandler(nil, invalidDataError)
                    }
                }
            } else {
                if response.status?.errorCodeString == "G00002" {
                }
                let error = ATPError(error: response.error, errorCodeString: response.status?.errorCodeString)
                completionHandler(nil, error)
            }
        }
    }
    
    fileprivate func post(url: String,
                          tokenValidationRequired: Bool,
                          body: Encodable?,
                          completionHandler: @escaping BaseResponseHandler) -> ATRequest {
        let request = ATRequest.request(url: url, method: .post)
        request.delegate = self
        request.setNeedsTokenValidation(tokenValidationRequired)
        request.setJsonBody(body: self.getJsonBody(forInput: body), ignoreParameterCreator: true)
        request.send(responseHandler: completionHandler)
        return request
    }
    
    func post<O: Decodable>(url: String,
                            tokenValidationRequired: Bool = false,
                            input: Encodable?,
                            completionHandler: @escaping (O?, ATPError?) -> Void) -> ATRequest {
        self.post(url: url,
                  tokenValidationRequired: tokenValidationRequired,
                  body: input,
                  parameterSelector: { $0.parametersJsonObject },
                  completionHandler: completionHandler)
    }
    
    func post<O: Decodable>(url: String,
                            tokenValidationRequired: Bool = false,
                            input: Encodable?,
                            completionHandler: @escaping ([O]?, ATPError?) -> Void) -> ATRequest {
        self.post(url: url,
                  tokenValidationRequired: tokenValidationRequired,
                  body: input,
                  parameterSelector: { $0.parametersJsonArray },
                  completionHandler: completionHandler)
    }
    
    func post(url: String,
              tokenValidationRequired: Bool = false,
              input: Encodable?,
              completionHandler: @escaping (Int64?, String?) -> Void) -> ATRequest {
        self.post(url: url,
                  tokenValidationRequired: tokenValidationRequired,
                  body: input) { response in
            if response.isSuccess, let result: Int64 = getValue(input: response.responseJsonObject, subscripts: "Parameters") {
                completionHandler(result, nil)
            } else {
                completionHandler(nil, response.error?.persianDescription)
            }
        }
    }

    // MARK: - JSON Builder
    public func getJsonBody(forInput input: Encodable?) -> JSONObject {
        var result: JSONObject = [
            "Identity": [
                "Token": ""
            ]
        ]

        if let inputJson = input?.toJson() {
            result["Parameters"] = inputJson
        }

        return result
    }
}

// MARK: - Delegate
extension AppNetwork: ATRequestDelegate {}
