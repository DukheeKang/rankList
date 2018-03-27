//
//  IndicatorView.swift
//  RankList
//
//  Created by Dukhee Kang on 2018. 3. 27..
//  Copyright © 2018년 Dukhee Kang. All rights reserved.
//

import UIKit

class IndicatorView {
    private var indicator = UIActivityIndicatorView()
    
    init() {
    }

    func activityIndicator(view:UIView) {
        indicator = UIActivityIndicatorView(frame: view.bounds)
        indicator.backgroundColor = UIColor(white: 0, alpha: 0.5)
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        view.addSubview(indicator)
    }
    func startIndicator() {
        indicator.startAnimating()
    }
    func stopIndicatior() {
        indicator.stopAnimating()
        
    }
}
