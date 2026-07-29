//
//  GetCardOCRResultUseCase.swift
//  ATOCR
//
//  Created by Amir on 7/28/26.
//

import AyanTechNetworkingLibrary
import Combine
import Foundation

protocol GetCardOCRResultUseCaseProtocol {
    func execute(
        url: String,
        token: String,
        input: OCRResultRequest
    ) -> AnyPublisher<OCRResultModel, ATErrorV2>
}

struct GetCardOCRResultUseCase: GetCardOCRResultUseCaseProtocol {

    private let repository: GetCardOCRResultRepositoryProtocol
    private let mapper: GetCardOCRResultMapper

    init(
        repository: GetCardOCRResultRepositoryProtocol,
        mapper: GetCardOCRResultMapper
    ) {
        self.repository = repository
        self.mapper = mapper
    }

    func execute(
        url: String,
        token: String,
        input: OCRResultRequest
    ) -> AnyPublisher<OCRResultModel, ATErrorV2> {

        getCardOCRResult(
            url: url,
            token: token,
            input: input
        )
    }

    private func getCardOCRResult(
        url: String,
        token: String,
        input: OCRResultRequest
    ) -> AnyPublisher<OCRResultModel, ATErrorV2> {

        repository.getCardOCRRessult(
            url: url,
            token: token,
            input: input
        )
        .flatMap { [mapper] response -> AnyPublisher<OCRResultModel, ATErrorV2> in

            switch response.status.lowercased() {

            case ResultStatusEnum.failed.lowercased:
                return Fail<OCRResultModel, ATErrorV2>(
                    error: ATErrorV2(
                        errorType: .api,
                        status: ATStatusV2(
                            message: response.description ?? ""
                        )
                    )
                )
                .eraseToAnyPublisher()

            case ResultStatusEnum.pending.lowercased:

                let delay = max(
                    (response.nextCallInterval ?? 0) / 1000.0,
                    0.5
                )

                return Just(())
                    .delay(
                        for: .seconds(delay),
                        scheduler: DispatchQueue.main
                    )
                    .setFailureType(to: ATErrorV2.self)
                    .flatMap { _ -> AnyPublisher<OCRResultModel, ATErrorV2> in

                        self.getCardOCRResult(
                            url: url,
                            token: token,
                            input: input
                        )
                    }
                    .eraseToAnyPublisher()

            case ResultStatusEnum.successful.lowercased:
                let mappedData = mapper.toUI(response)
                guard !mappedData.isEmpty else {
                    return Fail<OCRResultModel, ATErrorV2>(
                        error: ATErrorV2(errorType: .serialization)
                    )
                    .eraseToAnyPublisher()
                }

                return Just(mappedData)
                    .setFailureType(to: ATErrorV2.self)
                    .eraseToAnyPublisher()

            default:
                return Fail<OCRResultModel, ATErrorV2>(
                    error: ATErrorV2(
                        errorType: .serialization
                    )
                )
                .eraseToAnyPublisher()
            }
        }
        .eraseToAnyPublisher()
    }
}
