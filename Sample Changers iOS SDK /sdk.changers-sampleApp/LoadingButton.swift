//
//  LoadingButton.swift
//  sdk.changers-sampleApp
//
//  Created by Clement Yerochewski on 18/08/2020.
//  Copyright © 2020 Blacksquared Gmbh. All rights reserved.
//

import Foundation
import UIKit

protocol LoadingButtonDelegate: class {
    func openWebApp()
}
class LoadingButton: UIBarButtonItem {
    
    lazy var activityIndicator = UIActivityIndicatorView()

    weak var loadingButtonDelegate: LoadingButtonDelegate?
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 27, height: 25))
        button.setImage(UIImage(named: "logo"), for: .normal)
        button.setImage(UIImage(named: "logo"), for: .highlighted)
        button.addTarget(self, action: #selector(LoadingButton.openWebApp), for: .touchUpInside)
        return button
    }()
    
    func showLoading() {
        customView = activityIndicator
        activityIndicator.sizeToFit()
        activityIndicator.startAnimating()
        activityIndicator.color = UIColor.systemGray
        isEnabled = false
    }

    func hideLoading() {
        customView = button
        isEnabled = true
    }
    
    @objc private func openWebApp() {
        loadingButtonDelegate?.openWebApp()
    }

}
