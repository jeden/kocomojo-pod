//
//  EntitiesController.swift
//  KocomojoApp
//
//  Created by Antonio Bello on 1/27/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

import Foundation
import UIKit

import Kocomojo

class CountriesController: UITableViewController {
    private lazy var servicesManager = ServicesManager.instance
    private var entities: [Country]!
}

/// MARK: - Lifecycle
extension CountriesController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "generic.countries.label".localized
        loadEntities()
    }
}

/// MARK: - UITableViewDelegate
extension CountriesController : UITableViewDelegate {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

/// MARK: - UITableViewDataSource
extension CountriesController : UITableViewDataSource {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entities != nil ? self.entities.count : 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "country-cell"
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell ?? UITableViewCell(style: .Value1, reuseIdentifier: cellIdentifier)
        let country = self.entities[indexPath.row]
        cell.textLabel?.text = country.name
        cell.detailTextLabel?.text = country.isoCode
        
        return cell
    }
}

/// MARK: - Internals
extension CountriesController {
    private func loadEntities() {
        self.showProgress()
        
        self.servicesManager.getCountries { result in
            switch(result) {
            case .Error(let error):
                println(error.localizedDescription)
                
            case .Value(let countries):
                self.entities = countries()
                dispatch_async(dispatch_get_main_queue()) {
                    self.tableView.reloadData()
                 }
            }
            
            self.hideProgress()
        }
    }
}