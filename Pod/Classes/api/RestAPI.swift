//
//  RestAPI.swift
//  KocomojoKit
//
//  Created by Antonio Bello on 1/26/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

class RestAPI {
    // Singleton
    private struct Static {
        static var instance: RestAPI = RestAPI()
    }
    
    class var instance: RestAPI { return Static.instance }

    private lazy var _queue: NSOperationQueue = NSOperationQueue()
    
    private init() {}
}

/// MARK: - Interface
extension RestAPI {
    func getCountries(completion: ApiResult<CountriesResponse> -> ()) {
        let (verb, url) = ApiUrl.absoluteUrl(ApiUrl.Countries)
        invokeUrl(verb: verb, url: url, callback: completion)
    }

    func getPlans(completion: ApiResult<PlansResponse> -> ()) {
        let (verb, url) = ApiUrl.absoluteUrl(ApiUrl.Plans)
        invokeUrl(verb: verb, url: url, callback: completion)
    }
}

private extension RestAPI {    
    func invokeUrl<T where T: JsonDecodable, T: ApiResponseData>(# verb: HttpVerb, url: String, headers:[String:String] = [:], jsonDict: JsonDictionary? = nil, callback: ApiResult<T> -> ()) {
        var response: NSURLResponse
        var error: NSError?
        var requestHeaders = headers
        
        // Transform the json dictionary into the string and data counterparts
        let (jsonString, jsonData) = encodeFromJsonDict(jsonDict)
        
        // If the verb is GET and there's json data, encode the data in the query string
        let actualUrl = { () -> String in
            switch (verb) {
            case .GET where jsonString != nil:
                return "\(url)?\(jsonString!.utf8)"
            default:
                return url
            }
            }()
        
        let requestUrl = NSURL(string:actualUrl)
        let request: NSMutableURLRequest = NSMutableURLRequest()
        
        request.URL = requestUrl
        request.HTTPMethod = verb.rawValue
        
        // Set the request body for PUT, POST and DELETE if json data is provided
        if let json = jsonString {
            if verb != .GET {
                request.setValue("application/json; charset=utf-8", forHTTPHeaderField:"Content-Type")
                request.HTTPBody = json.dataUsingEncoding(NSUTF8StringEncoding)
            }
        }
        
        self.fillHeaders(&requestHeaders)
        
        for (key, value) in requestHeaders {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        // Send the request out
        NSURLConnection.sendAsynchronousRequest(request, queue: _queue) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> () in
            var result: ApiResult<T>
            if let error = error {
                result = .InvocationError(error)
            } else {
                var error: NSError?
                let dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &error) as? [String : AnyObject]
                if let error = error {
                    result = .InvocationError(error)
                } else {
                    if let dict = dict {
                        if let entity = ApiResponse<T>.decode(dict) {
                            if let data = entity.data {
                                result = .Value(data)
                            } else {
                                result = .InvocationError(NSError(domain: "kocomojo.kit", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response"]))
                            }
                        } else {
                            result = .InvocationError(NSError(domain: "kocomojo.kit", code: -2, userInfo: [NSLocalizedDescriptionKey: "Invalid JSON", "data": dict]))
                        }
                    } else {
                        result = .InvocationError(NSError(domain: "kocomojo.kit", code: -3, userInfo: [NSLocalizedDescriptionKey: "Empty response"]))
                    }
                }
            }
            callback(result)
        }
    }
    
    private func fillHeaders(inout headers: [String:String]) {
        // Set common headers, if any
    }
    
    private func encodeFromJsonDict(jsonDict: JsonDictionary?) -> (String?, NSData?) {
        var jsonString: String?
        var jsonData: NSData?
        var error: NSError?
        
        if let jsonDict = jsonDict {
            jsonData = NSJSONSerialization.dataWithJSONObject(jsonDict, options: nil, error: &error)
            
            switch (jsonData, error) {
            case (.Some(let jsonData), .None):
                jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding)
                break
            case (_, let .Some(error)):
                break
            case (.None, .None):
                break;
            }
        }
        return (jsonString, jsonData)
    }
}