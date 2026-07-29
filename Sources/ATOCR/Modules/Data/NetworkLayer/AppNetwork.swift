//
//  AppNetwork.swift
//  ATOCR
//
//  Created by Amir on 4/27/26.
//
//

import AyanTechNetworkingLibrary
import Combine

final class AppNetwork {
    func post<Input: Encodable & Sendable, Output: Decodable & Sendable>(
        url: String,
        parameters: Input,
        token: String) -> AnyPublisher<Output, ATErrorV2> {
            let configuration = ConfigurationV2(token: token)
            return ATRequestV2(
                url: url,
                parameters: parameters,
                configuration: configuration
            )
            .valuePublisher(Output.self)
        }
}
