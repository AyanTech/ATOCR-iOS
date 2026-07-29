//
//  GetCardOCRResultRepositoryImpl.swift
//  ATOCR
//
//  Created by Amir on 7/28/26.
//

import AyanTechNetworkingLibrary
import Combine

final class GetCardOCRResultRepositoryImpl: GetCardOCRResultRepositoryProtocol {
    private let remoteDataSource: GetCardOCRResultRemoteDataSourceProtocol
    
    init(remoteDataSource: GetCardOCRResultRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getCardOCRRessult(url: String,
                           token: String,
                           input: OCRResultRequest) -> AnyPublisher<GetCardOCRResultReponseDTO, ATErrorV2> {
        let inputDTO = GetCardOCRResultInputDTO.init(fileID: input.fileID)
        return remoteDataSource.getCardOCRResult(url: url,
                                                 token: token,
                                                 input: inputDTO)
        .eraseToAnyPublisher()
    }
}
