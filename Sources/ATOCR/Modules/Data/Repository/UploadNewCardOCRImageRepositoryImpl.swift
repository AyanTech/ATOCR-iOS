//
//  UploadNewCardOCRImageRepositoryImpl.swift
//  ATOCR
//
//  Created by Amir on 7/28/26.
//

import AyanTechNetworkingLibrary
import Combine

final class UploadNewCardOCRImageRepositoryImpl: UploadNewCardOCRImageRepositoryProtocol {
    private let remoteDataSource: UploadNewCardOCRImageRemoteDataSourceProtocol

    init(remoteDataSource: UploadNewCardOCRImageRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    func uploadNewCardOCRImage(url: String,
                               token: String,
                               input: UploadNewCardRequest) -> AnyPublisher<UploadNewCardOCRImageResponseDTO, ATErrorV2> {
        let inputDTO = UploadNewCardOCRImageInputDTO.init(imageArray: input.imageArray,
                                                          traceNumber: input.traceNumber,
                                                          type: input.type.rawValue)
        return remoteDataSource.uploadNewCard(url: url,
                                              token: token,
                                              input: inputDTO)
            .eraseToAnyPublisher()
    }
}
