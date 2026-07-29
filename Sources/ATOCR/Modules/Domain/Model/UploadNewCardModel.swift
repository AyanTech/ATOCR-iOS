//
//  UploadNewCardModel.swift
//  ATOCR
//
//  Created by Amir on 7/28/26.
//
import Foundation

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

public struct UploadNewCardRequest {
    let traceNumber: String
    let imageArray: [String]
    let type: OCRType
    
    public init(imageArray: [String],
         traceNumber: String,
         type: OCRType) {
        self.imageArray = imageArray
        self.traceNumber = traceNumber
        self.type = type
    }
    
    public init(imageArray: [String],
         type: OCRType) {
        self.imageArray = imageArray
        self.traceNumber = UUID().uuidString
        self.type = type
    }
}

struct UploadNewCardModel {
    let fileID: String
}
