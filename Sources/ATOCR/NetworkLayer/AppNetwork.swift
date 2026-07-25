//
//  AppNetwork.swift
//  ATOCR
//
//  Created by Amir on 4/27/26.
//
//

import Foundation
import AyanTechNetworkingLibrary

struct OCRAppNetworkError: LocalizedError, Sendable {
    let message: String
    let isUnauthorized: Bool
}

public final class AppNetwork: @unchecked Sendable {

    public static let shared = AppNetwork()

    private init() {}

    // MARK: - POST

    @discardableResult
    public func post<O: Decodable & Sendable>(url: String,
                                              input: Encodable,
                                              token: String,
                                              completionHandler: @escaping @MainActor (O?, Error?) -> Void) -> ATRequest {
        
        post(url: url,
             tokenValidationRequired: true,
             body: input,
             token: token,
             completionHandler: completionHandler)
    }

    // MARK: - POST Internal
    @discardableResult
    private func post<O: Decodable & Sendable>(url: String,
                                               tokenValidationRequired: Bool,
                                               body: Encodable?,
                                               token: String,
                                               completionHandler: @escaping @MainActor (O?, Error?) -> Void) -> ATRequest {
        let request = ATRequest.request(url: url, method: .post)
        let jsonBody = getJsonBody(forInput: body, token: token)

        request.setJsonBody(
                body: jsonBody,
                ignoreParameterCreator: true
            )
            .send { [weak self] response in
                guard self != nil else { return }

                let result: Result<O, Error> = Self.parseResponse(response)

                Task { @MainActor in
                    switch result {
                    case .success(let object):
                        completionHandler(object, nil)
                    case .failure(let error):
                        completionHandler(nil, error)
                    }
                }
            }
        return request
    }
    
    // MARK: - Response Parsing
    private static func parseResponse<O: Decodable & Sendable>(_ response: ATResponse) -> Result<O, Error> {
        let isUnauthorized = response.status?.errorCodeString == "G00002"
        guard response.isSuccess else {
            return .failure(
                OCRAppNetworkError(
                    message: response.error?.persianDescription ?? "خطا در برقراری ارتباط با سرور",
                    isUnauthorized: isUnauthorized
                )
            )
        }
        
        guard let parameters = response.parametersJsonObject else {
            return .failure(
                OCRAppNetworkError(
                    message: response.error?.persianDescription ?? "خطا در دریافت اطلاعات",
                    isUnauthorized: isUnauthorized
                )
            )
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters,
                                                  options: [])
            
            let object = try JSONDecoder().decode(O.self,
                                                  from: data)
            return .success(object)
            
        } catch {
            return .failure(
                OCRAppNetworkError(
                    message: "مشکل در خواندن اطلاعات از سرور",
                    isUnauthorized: false
                )
            )
        }
    }
    
    // MARK: - Request Body
    private func getJsonBody(forInput input: Encodable?, token: String) -> [String: Any] {
        var parameters: [String: Any] = [:]
        if let input {
            let encoder = JSONEncoder()
            if let data = try? encoder.encode(
                AnyEncodable(input)
            ),
               let jsonObject = try? JSONSerialization.jsonObject(
                with: data
               ) as? [String: Any] {
                parameters = jsonObject
            }
        }
        
        return [
            "Identity": [
                "Token": token
            ],
            "Parameters": parameters
        ]
    }
}

// MARK: - AnyEncodable
private struct AnyEncodable: Encodable {
    private let encodeClosure: (Encoder) throws -> Void
    
    init(_ value: Encodable) {
        self.encodeClosure = { encoder in
            try value.encode(to: encoder)
        }
    }

    func encode(to encoder: Encoder) throws {
        try encodeClosure(encoder)
    }
}
