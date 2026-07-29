//
//  OCRResultModel.swift
//  ATOCR
//
//  Created by Amir on 7/28/26.
//

public struct OCRResultRequest {
    public let fileID: String
}

public typealias OCRResultModel = [OCRResultItem]

public struct OCRResultItem: Sendable {
    public let key: String
    public let value: String
}
