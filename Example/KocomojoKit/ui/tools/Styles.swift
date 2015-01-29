//
//  Styles.swift
//  KocomojoApp
//
//  Created by Antonio Bello on 1/27/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

import Foundation
import UIKit

struct Styles {
    static func defaultButton(button: UIButton) {
        button.layer.cornerRadius = 2;
        button.backgroundColor = UIColor(red: 0.55, green: 0.55, blue: 0.55, alpha: 1.0)
        button.tintColor = UIColor.whiteColor()
    }
}