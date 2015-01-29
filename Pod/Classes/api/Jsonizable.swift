//
//  Jsonizable.swift
//  KocomojoKit
//
//  Created by Antonio Bello on 1/26/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

public protocol JsonDecodable {
    class func decode(json: JsonType) -> Self?
}

public protocol JsonEncodable {
    func encode() -> JsonDictionary
}

public protocol Jsonizable : JsonDecodable, JsonEncodable {
}

public typealias JsonType = AnyObject
public typealias JsonDictionary = Dictionary<String, JsonType>
public typealias JsonArray = Array<JsonType>

public func JsonString(object: JsonType?) -> String? { return object as? String }
public func JsonInt(object: JsonType?) -> Int? { return object as? Int }
public func JsonDouble(object: JsonType?) -> Double? { return object as? Double }
public func JsonBool(object: JsonType?) -> Bool? { return object as? Bool }
public func JsonDate(object: JsonType?) -> NSDate? { return NSDate.dateFromIso8610(JsonString(object)) }
public func JsonObject(object: JsonType?) -> JsonDictionary? { return object as? JsonDictionary }
public func JsonArrayType(object: JsonType?) -> JsonArray? { return object as? JsonArray }
public func JsonEntity<T: JsonDecodable>(object: JsonType?) -> T? {
    if let object: JsonType = object {
        return T.decode(object)
    }
    return .None
}

infix operator >>> { associativity left precedence 150 }
public func >>> <A, B>(a: A?, f: A -> B?) -> B? {
    if let x = a {
        return f(x)
    }
    return .None
}


infix operator <^> { associativity left }
public func <^> <A, B>(f: A -> B, a: A?) -> B? {
    if let x = a {
        return f(x)
    }
    return .None
}


infix operator <&&> { associativity left }
public func <&&> <A, B>(f: (A -> B)?, a: A?) -> B? {
    if let x = a {
        if let fx = f {
            return fx(x)
        }
    }
    return .None
}

infix operator <||> { associativity left }
public func <||> <A, B>(f: (A? -> B)? , a: A?) -> B? {
    if let fx = f {
        return fx(a != nil ? a : .None)
    }
    return .None
}

extension NSDate {
    public class func dateFromIso8610(jsonDate: String?) -> NSDate? {
        if let jsonDate = jsonDate {
            let iso8610DateFormatter = NSDateFormatter()
            iso8610DateFormatter.timeStyle = .FullStyle
            iso8610DateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
            return iso8610DateFormatter.dateFromString(jsonDate)
        }
        
        return .None
    }
}