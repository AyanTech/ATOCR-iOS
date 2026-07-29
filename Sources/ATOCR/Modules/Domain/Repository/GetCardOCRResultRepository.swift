//
//  GetCardOCRResultRepository.swift
//  ATOCR
//
//  Created by Amir on 7/28/26.
//

import AyanTechNetworkingLibrary
import Combine

protocol GetCardOCRResultRepositoryProtocol {
    func getCardOCRRessult(url: String,
                           token: String,
                           input: OCRResultRequest) -> AnyPublisher<GetCardOCRResultReponseDTO, ATErrorV2>
}
