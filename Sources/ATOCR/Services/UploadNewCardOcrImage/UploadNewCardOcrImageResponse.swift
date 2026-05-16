//
//  UploadNewCardOcrImageResponse.swift
//  ATOCR
//
//  Created by Amir on 5/5/26.
//

public struct UploadNewCardOcrImageResponse: Decodable {
    let fileID: String?

    enum CodingKeys: String, CodingKey {
        case fileID = "FileID"
    }
}
