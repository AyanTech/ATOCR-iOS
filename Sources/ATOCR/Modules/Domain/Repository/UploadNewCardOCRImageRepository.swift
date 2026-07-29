//
//  UploadNewCardOCRImageRepository.swift
//  ATOCR
//
//  Created by Amir on 7/28/26.
//

import AyanTechNetworkingLibrary
import Combine

protocol UploadNewCardOCRImageRepositoryProtocol {
    func uploadNewCardOCRImage(url: String,
                               token: String,
                               input: UploadNewCardRequest) -> AnyPublisher<UploadNewCardOCRImageResponseDTO, ATErrorV2>
}
