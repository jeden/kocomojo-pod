//
//  ViewController.swift
//  KocomojoApp
//
//  Created by Antonio Bello on 1/25/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    
    @IBOutlet weak var btnCountries: UIButton!
    @IBOutlet weak var btnPlans: UIButton!
    
}

/// MARK: - Lifecycle
extension MainController {
    override func viewDidLoad() {
        super.viewDidLoad()

        Styles.defaultButton(self.btnCountries)
        self.btnCountries.setTitle("generic.countries.label".localized, forState: .Normal)
        
        Styles.defaultButton(self.btnPlans)
        self.btnPlans.setTitle("generic.plans.label".localized, forState: .Normal)
    }
}

