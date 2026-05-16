//
//  OCRChangeHandler.swift
//  ATOCR
//
//  Created by Amir on 5/5/26.
//

import AyanTechNetworkingLibrary

public enum OCRChangeHandler {
    case isLoading(ATRequest? = nil, Bool, completion: (() -> Void)? = nil)
    case didSuccess
    case didError(ATPError)
}
