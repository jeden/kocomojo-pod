
//
//  CountriesResponse.swift
//  KocomojoKit
//
//  Created by Antonio Bello on 1/26/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

struct CountriesResponse : JsonDecodable, ApiResponseData {
    private(set) var countries: [Country]
    
    static var dataEntityName: String { return "countries" }
    
    init() {
        self.countries = []
    }
    
    init(countries: [Country]) {
        self.countries = countries
    }
    
    private static func create(countries: [Country]) -> CountriesResponse {
        return CountriesResponse(countries: countries)
    }
    
    static func decode(json: JsonType) -> CountriesResponse? {
        var countriesResponse: CountriesResponse?
        
        if let countries = json as? JsonArray {
            var countryEntities = [Country]()
            for country in countries {
                let dict = country as JsonDictionary
                if let countryEntity = Country.decode(dict) {
                    countryEntities.append(countryEntity)
                }
            }
            
            countriesResponse = CountriesResponse(countries: countryEntities)
        }
        
        return countriesResponse
    }
}