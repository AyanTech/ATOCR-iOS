//
//  GetCardOcrResultInput.swift
//  ATOCR
//
//  Created by Amir on 5/5/26.
//

struct GetCardOcrResultInput: Codable {
    let fileID: String

    enum CodingKeys: String, CodingKey {
        case fileID = "FileID"
    }
}
