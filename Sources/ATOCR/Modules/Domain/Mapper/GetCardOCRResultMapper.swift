//
//  GetCardOCRResultMapper.swift
//  ATOCR
//
//  Created by Amir on 7/28/26.
//

struct GetCardOCRResultMapper {
    func toUI(_ dto: GetCardOCRResultReponseDTO) -> OCRResultModel {
        return dto.result?.map { OCRResultItem(key: $0.key,
                                               value: $0.value)} ?? []
    }
}
