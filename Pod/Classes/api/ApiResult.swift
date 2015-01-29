//
//  ApiResult.swift
//  KocomojoKit
//
//  Created by Antonio Bello on 1/26/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

enum ApiResult<T where T: JsonDecodable, T: ApiResponseData> {
    case Value(@autoclosure () -> T)
    case HttpError(Int)
    case InvocationError(NSError)
    
    var succeeded: Bool {
        return !hasError
    }
    
    var hasError: Bool {
        switch(self) {
        case .HttpError: return true
        case .Value: return false
        case .InvocationError: return false
        }
    }   
}
