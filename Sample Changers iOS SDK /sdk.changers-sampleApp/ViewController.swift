//
//  ViewController.swift
//  sdk.changers-sampleApp
//
//  Created by Clement Yerochewski on 20/05/2020.
//  Copyright © 2020 Blacksquared Gmbh. All rights reserved.
//

import UIKit
import ChangersSDK

protocol SDKWrapperDelegate {
    func updateUI()
}


class ViewController: UIViewController {
    
    @IBOutlet weak var openWeb: LoadingButton!
    @IBOutlet weak var copyUUIDButton: LoadingButton!
    private weak var appDelegate: AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        copyUUIDButton.showLoading()
        copyUUIDButton.isEnabled = true
        openWeb.showLoading()
        openWeb.isEnabled = false
        
        if let del = UIApplication.shared.delegate as? AppDelegate {
            self.appDelegate = del
            appDelegate.sdkDelegate = self
        }
        else {
            exit(0)
        }
    }
    
    @IBAction func openWebAction() {
        if Changers.isReady {
            Changers.loadWebApp(on: self, debug: true)
        } else {
            appDelegate.changers.setup()
        }
    }
    
    @IBAction func copiedAction() {
        if let changersUUID = ChangersHelper.changersUUID {
            UIPasteboard.general.setValue("changers user id: \(changersUUID) \n\n automatic tracking id: \(appDelegate.changers.motionTagUUID ?? "null") \n\n user token: \(appDelegate.changers.userToken ?? "null")"  , forPasteboardType: "public.utf8-plain-text")
            let alert = UIAlertController(title: "[Changers SDK]", message: "User credentials copied to clipboard ✅", preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(continueAction)
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "[Changers SDK] UUID", message: "UUID not ready yet.", preferredStyle: .alert)
            let continueAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(continueAction)
            self.present(alert, animated: true)
        }
    }
}

extension ViewController: SDKWrapperDelegate {
    
    func updateUI() {
        openWeb.hideLoading()
        copyUUIDButton.hideLoading()
        if let changersUUID = ChangersHelper.changersUUID {
            copyUUIDButton.setTitle(changersUUID, for: .normal)
        } else {
            copyUUIDButton.setTitle("n/a", for: .normal)
        }
    }
    
}
