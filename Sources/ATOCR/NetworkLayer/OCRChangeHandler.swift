//
//  OCRChangeHandler.swift
//  ATOCR
//
//  Created by Amir on 5/5/26.
//

import AyanTechNetworkingLibrary

public enum OCRChangeHandler {
    case isLoading(ATRequest?, Bool)
    case didSuccess
    case didError(String)
    case didUnauthorized
}
