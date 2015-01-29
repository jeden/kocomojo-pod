//
//  PlanFeaturesController.swift
//  KocomojoApp
//
//  Created by Antonio Bello on 1/27/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

import Foundation
import UIKit

class PlanFeaturesController: UITableViewController {
    private var features: [String]!
}

/// MARK: - Public interface
extension PlanFeaturesController {
    func configure(features: [String]) {
        self.features = features
    }
}

/// MARK: - UITableViewDelegate
extension PlanFeaturesController : UITableViewDelegate {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

/// MARK: - UITableViewDataSource
extension PlanFeaturesController : UITableViewDataSource {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.features.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "feature-cell"

        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell ?? UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        let feature = self.features[indexPath.row]
        cell.textLabel?.text = feature

        return cell
    }
}
