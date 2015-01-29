//
//  String+Localization.swift
//  KocomojoApp
//
//  Created by Antonio Bello on 1/27/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

import Foundation

extension String {
    var localized: String { return NSLocalizedString(self, comment: "") }
}