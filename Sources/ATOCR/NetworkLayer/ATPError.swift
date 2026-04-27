//
//  ATPError.swift
//  ATOCR
//
//  Created by Amir on 4/27/26.
//
import AyanTechNetworkingLibrary

public struct ATPError {
    var persianDescription: String?
    var code: Int?
    var type: ATErrorType?
    var name: String!
    var errorCodeString: String?
    
    init(error: ATError? = nil,
         description: String? = nil,
         errorCodeString: String? = nil) {
        self.persianDescription = description ?? error?.persianDescription
        self.code = error?.code
        self.type = error?.type
        self.name = error?.name
        self.errorCodeString = errorCodeString
    }
}
