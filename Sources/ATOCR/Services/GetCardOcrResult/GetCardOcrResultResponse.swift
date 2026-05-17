//
//  GetCardOcrResultResponse.swift
//  ATOCR
//
//  Created by Amir on 5/5/26.
//

public struct GetCardOcrResultResponse: Decodable {
    public let cardID: String?
    public let description: String?
    public let nextCallInterval: Double?
    public let result: [OCRKeyValueModel]?
    public let retryable: Bool?
    public let status: String
    
    enum CodingKeys: String, CodingKey {
        case cardID = "CardID"
        case description = "Description"
        case nextCallInterval = "NextCallInterval"
        case result = "Result"
        case retryable = "Retryable"
        case status = "Status"
    }
}

public struct OCRKeyValueModel: Decodable {
    public let key: String
    public let value: String
    
    enum Coding: String, CodingKey {
        case key = "Key"
        case value = "Value"
    }
}
