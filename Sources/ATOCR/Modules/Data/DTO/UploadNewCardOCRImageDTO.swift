//
//  UploadNewCardOCRImageDTO.swift
//  ATOCR
//
//  Created by Amir on 7/28/26.
//
import Foundation

struct UploadNewCardOCRImageInputDTO: Encodable, Sendable {
    let imageArray: [String]
    let traceNumber: String
    let type: String
    
    init(imageArray: [String],
         traceNumber: String,
         type: String) {
        self.imageArray = imageArray
        self.traceNumber = traceNumber
        self.type = type
    }
    
    enum CodingKeys: String, CodingKey {
        case imageArray = "ImageArray"
        case traceNumber = "TraceNumber"
        case type = "Type"
    }
}

struct UploadNewCardOCRImageResponseDTO: Decodable, Sendable {
    public let fileID: String
    
    enum CodingKeys: String, CodingKey {
        case fileID = "FileID"
    }
}
