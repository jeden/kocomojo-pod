//
//  UIViewController+Progress.swift
//  KocomojoApp
//
//  Created by Antonio Bello on 1/27/15.
//  Copyright (c) 2015 Elapsus. All rights reserved.
//

import Foundation
import UIKit

/// Extension to add and show an activity indicator
extension UIViewController {
    private var viewTag: Int { return 85321 }
    
    private var progressView: UIActivityIndicatorView? {
        return self.view.viewWithTag(self.viewTag) as? UIActivityIndicatorView
    }
    
    func showProgress() {
        if let progressView = self.progressView {
            progressView.startAnimating()
        } else {
            let progressView = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
            progressView.frame = CGRectMake(0.0, 0.0, 40.0, 40.0);
            progressView.center = self.view.center;
            progressView.tag = self.viewTag
            self.view.addSubview(progressView)
            progressView.bringSubviewToFront(self.view)
            progressView.startAnimating()
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func hideProgress() {
        dispatch_async(dispatch_get_main_queue()) {
            self.progressView?.stopAnimating()
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
}