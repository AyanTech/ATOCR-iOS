//
//  GetCardOcrResultResponse.swift
//  ATOCR
//
//  Created by Amir on 5/5/26.
//

struct GetCardOcrResultResponse: Decodable {
    let cardID: String
    let description: String
    let nextCallInterval: Double
    let result: OCRKeyValueModel
    let retryable: Bool
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case cardID = "CardID"
        case description = "Description"
        case nextCallInterval = "NextCallInterval"
        case result = "result"
        case retryable = "Retryable"
        case status = "Status"
    }
}

struct OCRKeyValueModel: Decodable {
    let key: String
    let value: String
    
    enum Coding: String, CodingKey {
        case key = "Key"
        case value = "Value"
    }
}
