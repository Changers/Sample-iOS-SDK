//
//  ViewController.swift
//  sdk.changers-sampleApp
//
//  Created by Clement Yerochewski on 20/05/2020.
//  Copyright © 2020 Blacksquared Gmbh. All rights reserved.
//

import UIKit
import ChangersSDK
import WebKit

protocol SDKWrapperDelegate {
    func updateUI()
}


class ViewController: UIViewController {
    
    @IBOutlet weak var openWeb: LoadingButton!

    private weak var appDelegate: AppDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        openWeb.loadingButtonDelegate = self
        self.updateUI()
        if let del = UIApplication.shared.delegate as? AppDelegate {
            self.appDelegate = del
            appDelegate.sdkDelegate = self
        }
        else {
            exit(0)
        }
    }

    @IBAction func copiedAction() {
        if let changersUUID = ChangersHelper.changersUUID {
            UIPasteboard.general.setValue("environement : \(ChangersHelper.changersEnv) \n\n changers user id: \(changersUUID) \n\n automatic tracking id: \(appDelegate.changers.motionTagUUID ?? "null") \n\n user token: \(appDelegate.changers.userToken ?? "null")"  , forPasteboardType: "public.utf8-plain-text")
            let alert = UIAlertController(title: "[Changers SDK \(Changers.versionBuildSDK) - \(ChangersHelper.changersEnv))]", message: "User credentials copied to clipboard ✅", preferredStyle: .alert)
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
        if !Changers.isReady {
            openWeb.showLoading()
        } else {
            openWeb.hideLoading()
        }
    }
    
}

extension ViewController: LoadingButtonDelegate {
    
    func openWebApp() {
        if Changers.isReady {
            Changers.loadWebApp(on: self, debug: true)
        } else {
            openWeb.showLoading()
            appDelegate.changers.setup()
        }
    }
}
