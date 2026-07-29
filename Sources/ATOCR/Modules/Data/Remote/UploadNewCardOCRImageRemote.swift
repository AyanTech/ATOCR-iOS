//
//  UploadNewCardOCRImageRemote.swift
//  ATOCR
//
//  Created by Amir on 7/28/26.
//

import AyanTechNetworkingLibrary
import Combine

protocol UploadNewCardOCRImageRemoteDataSourceProtocol {
    func uploadNewCard(url: String,
                       token: String,
                       input: UploadNewCardOCRImageInputDTO) -> AnyPublisher<UploadNewCardOCRImageResponseDTO, ATErrorV2>
}

final class UploadNewCardOCRImageRemoteDataSource: UploadNewCardOCRImageRemoteDataSourceProtocol {
    private let appNetwork: AppNetwork

    init(appNetwork: AppNetwork) {
        self.appNetwork = appNetwork
    }

    func uploadNewCard(url: String,
                       token: String,
                       input: UploadNewCardOCRImageInputDTO) -> AnyPublisher<UploadNewCardOCRImageResponseDTO, ATErrorV2> {
        appNetwork.post(
            url: url,
            parameters: input,
            token: token
        )
    }
}
