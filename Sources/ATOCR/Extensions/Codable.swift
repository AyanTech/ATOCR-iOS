//
//  CodableExtensions.swift
//  ATOCR
//
//  Created by Amir on 4/27/26.
//

import Foundation

extension Decodable {
    init?(withJsonObject: Any?) {
        guard let object = withJsonObject else {
            return nil
        }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: object, options: JSONSerialization.WritingOptions())
            let decodable = try JSONDecoder().decode(Self.self, from: jsonData)
            self = decodable
        } catch {
            print(error)
            return nil
        }
    }

    init?(withJsonString: String?) {
        self.init(withJsonObject: withJsonString?.toJsonObject())
    }
}

extension Encodable {
    func toJson() -> Any? {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
    }

    func toJsonString() -> String? {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }
}
