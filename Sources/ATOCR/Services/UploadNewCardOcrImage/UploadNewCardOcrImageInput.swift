//
//  UploadNewCardOcrImageInput.swift
//  ATOCR
//
//  Created by Amir on 5/5/26.
//
import Foundation

public struct UploadNewCardOcrImageInput: Codable {
    let imageArray: [String]
    let traceNumber: String
    let type: String

    public init(imageArray: [String],
                traceNumber: String,
                type: OCRType) {
        self.imageArray = imageArray
        self.traceNumber = traceNumber
        self.type = type.rawValue
    }

    public init(imageArray: [String],
                type: OCRType) {
        self.imageArray = imageArray
        self.traceNumber = UUID().uuidString
        self.type = type.rawValue
    }

    enum CodingKeys: String, CodingKey {
        case imageArray = "ImageArray"
        case traceNumber = "TraceNumber"
        case type = "Type"
    }
}

public enum OCRType: String {
    case vehicleCard = "VehicleCard"
    case vehicleCardFrontSide = "VehicleCardFrontSide"
    case nationalCard = "NationalCard"
    case nationalCardBackside = "NationalCardBackside"
    case bankCard = "BankCard"
    case legalDrivingRecordsInquiry = "LegalDrivingRecordsInquiry"
    case nationalCardOwnerImage = "NationalCardOwnerImage"
    case nationalCardCompleteInfo = "NationalCardCompleteInfo"
    case cargreenSheet = "CargreenSheet"
    case cargreenSheetCardFinder = "CargreenSheetCardFinder"
}
