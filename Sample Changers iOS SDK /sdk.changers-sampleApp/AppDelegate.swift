//
//  AppDelegate.swift
//  sdk.changers-sampleApp
//
//  Created by Clement Yerochewski on 20/05/2020.
//  Copyright © 2020 Blacksquared Gmbh. All rights reserved.
//

import UIKit
//import Firebase
import ChangersSDK


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var sdkDelegate:SDKWrapperDelegate? = nil
    lazy var changers = Changers()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        FirebaseApp.configure()
        changers.delegate = self
        changers.initSDK(with: ChangersHelper.config, uuid: ChangersHelper.changersUUID)
        return true
    }
}


extension AppDelegate: ChangersDelegate {

    func setupDidFinish(with uiid: String) {
        ChangersHelper.changersUUID = uiid
        sdkDelegate?.updateUI()
    }

    func setupDidFail(with error: ChangersAuthenticateError?) {
        sdkDelegate?.updateUI()
    }
}


