//
//  PlansController.swift
//  KocomojoApp
//
//  Created by Antonio Bello on 1/27/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

import UIKit
import Foundation

import Kocomojo

class PlansController: UITableViewController {
    private lazy var servicesManager = ServicesManager.instance
    private var entities: [Plan]!
}

/// MARK: - Lifecycle
extension PlansController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "generic.plans.label".localized
        
        loadEntities()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier {
        case .Some("show-features"):
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let plan = self.entities[indexPath.row]
                let vc = segue.destinationViewController as PlanFeaturesController
                vc.configure(plan.features.sorted(<))
            }
        default:
            break
        }
    }
}

/// MARK: - UITableViewDelegate
extension PlansController : UITableViewDelegate {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("show-features", sender: self)
    }
}

/// MARK: - UITableViewDataSource
extension PlansController : UITableViewDataSource {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entities != nil ? self.entities.count : 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "plan-cell"

        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell ?? UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        let plan = self.entities[indexPath.row]
        let price = NSString(format: "%.2f", plan.monthlyFee)
        cell.textLabel?.text = "\(plan.name) (\(price))"
        cell.detailTextLabel?.text = "\(plan.description) (\(plan.nickName))"
        cell.backgroundColor = plan.recommended ? UIColor(red: 0.8, green: 0.96, blue: 0.8, alpha: 1.0) : UIColor.whiteColor()
        cell.accessoryType = .DisclosureIndicator

        return cell
    }
}

/// MARK: - Internals
extension PlansController {
    private func loadEntities() {
        self.showProgress()

        self.servicesManager.getPlans { result in
            switch(result) {
            case .Error(let error):
                println(error.localizedDescription)

            case .Value(let plans):
                self.entities = plans()
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                }
            }

            self.hideProgress()
        }
    }
}