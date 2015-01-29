//
//  Settings.swift
//  KocomojoKit
//
//  Created by Antonio Bello on 1/26/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

protocol ISettings {
    var baseUrl: String { get }
}

struct Settings : ISettings {
    static let instance: ISettings = Settings()
    
    private init() {}
    
    var baseUrl: String { return "https://admin.kocomojo.net/api/v2/services" }
}