//
//  GetCardOcrResultInput.swift
//  ATOCR
//
//  Created by Amir on 5/5/26.
//

public struct GetCardOcrResultInput: Codable {
    let fileID: String
    
    public init(fileID: String) {
        self.fileID = fileID
    }
    
    enum CodingKeys: String, CodingKey {
        case fileID = "FileID"
    }
}
