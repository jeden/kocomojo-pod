//
//  ApiUrl.swift
//  KocomojoKit
//
//  Created by Antonio Bello on 1/26/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

enum HttpVerb : String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

enum ApiUrl : String {
    private static let settings: ISettings = Settings.instance
    
    case Countries = "GET;/countries"
    case Plans = "GET;/plans"
    
    static func absoluteUrl(apiUrl: ApiUrl) -> (verb: HttpVerb, url: String) {
        var parts = apiUrl.rawValue.componentsSeparatedByString(";")
        var (verbText, urlText) = (parts[0], parts[1])
        
        var verb = HttpVerb(rawValue: verbText)!
        var url = self.settings.baseUrl + urlText
        
        return (verb, url)
    }
}