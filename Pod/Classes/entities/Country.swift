//
//  Country.swift
//  KocomojoKit
//
//  Created by Antonio Bello on 1/26/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

public struct Country {
    public var name: String
    public var isoCode: String
    
    init(name: String, isoCode: String) {
        self.name = name
        self.isoCode = isoCode
    }
}

extension Country : JsonDecodable {
    static func create(name: String)(isoCode: String) -> Country {
        return Country(name: name, isoCode: isoCode)
    }
    
    public static func decode(json: JsonType) -> Country? {
        let a = Country.create <^> json["name"] >>> JsonString
        let b = a <&&> json["iso_code"] >>> JsonString
        return b
    }
}

extension Country : Printable {
    public var description: String { return "name: \(name) - isoCode: \(isoCode)" }
}