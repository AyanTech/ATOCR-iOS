//
//  UploadNewCardOCRUseCase.swift
//  ATOCR
//
//  Created by Amir on 7/28/26.
//

import AyanTechNetworkingLibrary
import Combine

protocol UploadNewCardOCRUseCaseProtocol {
    func execute(url: String,
                 token: String,
                 input: UploadNewCardRequest) -> AnyPublisher<UploadNewCardModel, ATErrorV2>
}

struct UploadNewCardOCRUseCase: UploadNewCardOCRUseCaseProtocol {
    private let repository: UploadNewCardOCRImageRepositoryProtocol
    private let mapper: UploadNewCardOCRImageMapper

    init(repository: UploadNewCardOCRImageRepositoryProtocol,
         mapper: UploadNewCardOCRImageMapper) {
        self.repository = repository
        self.mapper = mapper
    }

    func execute(url: String,
                 token: String,
                 input: UploadNewCardRequest) -> AnyPublisher<UploadNewCardModel, ATErrorV2> {
        repository.uploadNewCardOCRImage(url: url, token: token, input: input)
            .map(mapper.toUI(_:))
            .eraseToAnyPublisher()
    }
}
