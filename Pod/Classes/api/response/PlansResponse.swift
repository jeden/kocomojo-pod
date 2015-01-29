
//
//  CountriesResponse.swift
//  KocomojoKit
//
//  Created by Antonio Bello on 1/26/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

struct PlansResponse : JsonDecodable, ApiResponseData {
    private(set) var plans: [Plan]
    
    static var dataEntityName: String { return "plans" }
    
    init() {
        self.plans = []
    }
    
    init(plans: [Plan]) {
        self.plans = plans
    }
    
    private static func create(plans: [Plan]) -> PlansResponse {
        return PlansResponse(plans: plans)
    }
    
    static func decode(json: JsonType) -> PlansResponse? {
        var plansResponse: PlansResponse?
        
        if let plans = json as? JsonArray {
            var planEntities = [Plan]()
            for plan in plans {
                let dict = plan as JsonDictionary
                if let planEntity = Plan.decode(dict) {
                    planEntities.append(planEntity)
                }
            }
            
            plansResponse = PlansResponse(plans: planEntities)
        }
        
        return plansResponse
    }
}