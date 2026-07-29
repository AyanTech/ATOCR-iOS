//
//  GetCardOcrResultDTO.swift
//  ATOCR
//
//  Created by Amir on 7/28/26.
//

struct GetCardOCRResultInputDTO: Codable, Sendable {
    let fileID: String
    
    init(fileID: String) {
        self.fileID = fileID
    }
    
    enum CodingKeys: String, CodingKey {
        case fileID = "FileID"
    }
}

struct GetCardOCRResultReponseDTO: Decodable, Sendable {
    let cardID: String?
    let description: String?
    let nextCallInterval: Double?
    let result: OCRResultDTO?
    let retryable: Bool?
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case cardID = "CardID"
        case description = "Description"
        case nextCallInterval = "NextCallInterval"
        case result = "Result"
        case retryable = "Retryable"
        case status = "Status"
    }
}

typealias OCRResultDTO = [OCRResultModelDTO]

struct OCRResultModelDTO: Decodable, Sendable {
    let key: String
    let value: String
    
    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case value = "Value"
    }
}
