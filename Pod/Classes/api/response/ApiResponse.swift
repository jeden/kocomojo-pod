//
//  ApiResponse.swift
//  KocomojoKit
//
//  Created by Antonio Bello on 1/26/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

protocol ApiResponseData {
    /// Overrideable property defining the name of the data field returned in the json response
    /// :return: the name of the field containing the data returned by the API
    class var dataEntityName: String { get }
}

final class ApiResponse<T where T: ApiResponseData, T: JsonDecodable> : JsonDecodable {
    private(set) var responseType: String
    private(set) var data: T?
    
    init(responseType: String, data: T?) {
        self.responseType = responseType
        self.data = data
    }
    
    private class func create(responseType: String)(data: T?) -> ApiResponse {
        return ApiResponse(responseType: responseType, data: data)
    }
    
    class func decode(json: JsonType) -> ApiResponse<T>? {
        let a = ApiResponse.create <^> json["resp_type"] >>> JsonString
        let b = a <||> json[T.dataEntityName] >>> JsonEntity
        
        return b
    }
}
