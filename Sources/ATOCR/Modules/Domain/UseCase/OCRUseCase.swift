//
//  OCRUseCase.swift
//  ATOCR
//
//  Created by Amir on 7/28/26.
//

import AyanTechNetworkingLibrary
import Combine
import Foundation

protocol OCRUseCaseProtocol {
    func execute(
        uploadImageURL: String,
        resultOCRUrl: String,
        token: String,
        input: UploadNewCardRequest
    ) -> AnyPublisher<OCRResultModel, ATErrorV2>
}

public struct OCRUseCase: OCRUseCaseProtocol {
    private let uploadUseCase: UploadNewCardOCRUseCaseProtocol
    private let resultUseCase: GetCardOCRResultUseCaseProtocol
    
    public init() {
        let uploadRemoteDataSource = UploadNewCardOCRImageRemoteDataSource(appNetwork: AppNetwork())
        let uploadMapper = UploadNewCardOCRImageMapper()
        let uploadRepository = UploadNewCardOCRImageRepositoryImpl(remoteDataSource: uploadRemoteDataSource)
        let uploadUseCase = UploadNewCardOCRUseCase(repository: uploadRepository, mapper: uploadMapper)
        self.uploadUseCase = uploadUseCase
        let resultRemoteDataSource = GetCardOCRResultRemoteDataSource(appNetwork: AppNetwork())
        let resultMapper = GetCardOCRResultMapper()
        let resultRepository = GetCardOCRResultRepositoryImpl(remoteDataSource: resultRemoteDataSource)
        let resultUseCase = GetCardOCRResultUseCase(repository: resultRepository, mapper: resultMapper)
        self.resultUseCase = resultUseCase
    }
    
    public func execute(
        uploadImageURL: String,
        resultOCRUrl: String,
        token: String,
        input: UploadNewCardRequest
    ) -> AnyPublisher<OCRResultModel, ATErrorV2> {
        uploadUseCase
            .execute(
                url: uploadImageURL,
                token: token,
                input: input
            )
            .flatMap { [resultUseCase] response in
                resultUseCase.execute(
                    url: resultOCRUrl,
                    token: token,
                    input: .init(fileID: response.fileID)
                )
            }
            .eraseToAnyPublisher()
    }
}
