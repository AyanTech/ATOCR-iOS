//
//  GetCardOCRResultRemote.swift
//  ATOCR
//
//  Created by Amir on 7/28/26.
//

import AyanTechNetworkingLibrary
import Combine

protocol GetCardOCRResultRemoteDataSourceProtocol {
    func getCardOCRResult(url: String,
                          token: String,
                          input: GetCardOCRResultInputDTO) -> AnyPublisher<GetCardOCRResultReponseDTO, ATErrorV2>
}

final class GetCardOCRResultRemoteDataSource: GetCardOCRResultRemoteDataSourceProtocol {
    private let appNetwork: AppNetwork

    init(appNetwork: AppNetwork) {
        self.appNetwork = appNetwork
    }

    func getCardOCRResult(url: String,
                          token: String,
                          input: GetCardOCRResultInputDTO) -> AnyPublisher<GetCardOCRResultReponseDTO, ATErrorV2> {
        appNetwork.post(url: url,
                        parameters: input,
                        token: token)
    }
}
