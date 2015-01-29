//
//  Plan.swift
//  KocomojoKit
//
//  Created by Antonio Bello on 1/26/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

public struct Plan {
    public var recommended: Bool
    public var nickName: String
    public var name: String
    public var description: String
    public var monthlyFee: Double
    public var features: [String]
    
    init(recommended: Bool, nickName: String, name: String, description: String, monthlyFee: Double, features: [String]) {
        self.recommended = recommended
        self.nickName = nickName
        self.name = name
        self.description = description
        self.monthlyFee = monthlyFee
        self.features = features
    }
}

extension Plan : JsonDecodable {
    static func create(recommended: Bool)(nickName: String)(name: String)(description: String)(monthlyFee: Double)(features: [JsonType]) -> Plan {
        return Plan(recommended: recommended, nickName: nickName, name: name, description: description, monthlyFee: monthlyFee, features: features as [String])
    }

    public static func decode(json: JsonType) -> Plan? {
        let a = Plan.create <^> json["recommended"] >>> JsonBool
        let b = a <&&> json["nick_name"] >>> JsonString
        let c = b <&&> json["name"] >>> JsonString
        let d = c <&&> json["description"] >>> JsonString
        let e = d <&&> json["monthly_fee"] >>> JsonDouble
        let f = e <&&> json["features"] >>> JsonArrayType
        return f
    }
}
