//
//  UploadNewCardOCRImageMapper.swift
//  ATOCR
//
//  Created by Amir on 7/28/26.
//

struct UploadNewCardOCRImageMapper {
    func toUI(_ dto: UploadNewCardOCRImageResponseDTO) -> UploadNewCardModel {
        return UploadNewCardModel(fileID: dto.fileID)
    }
}
