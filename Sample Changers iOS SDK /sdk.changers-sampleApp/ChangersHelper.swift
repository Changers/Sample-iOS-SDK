//
//  ChangersHelper.swift
//  sdk.changers-sampleApp
//
//  Created by Clement Yerochewski on 13/08/2020.
//  Copyright © 2020 Blacksquared Gmbh. All rights reserved.
//

import Foundation
import ChangersSDK

extension ChangersEnv {
    
    var clientSecret: String {
        switch self {
        case .development:
            return "xVpnijCWWX7mPaL0CLEy6GIBN207cGMA9DPKKMnn"
        case .production:
            return "not_yet_available"
        case .stage:
            return "HPMXkWyeMLIDpLzmYPM1dGz0B60wJoyajwrk3zHB"
        }
    }
}

struct ChangersHelper {
    
    static var config: ChangersConfig {
        let env = ChangersEnv.stage
        return ChangersConfig(clientId: 2,
                              clientSecret: env.clientSecret,
                              clientName: "darmstadt",
                              environment: env
        )
    }

    static var changersUUID: String? {
        set(uuid) {
            UserDefaults.standard.set(uuid, forKey: "userUUID")
        }
        get {
            return UserDefaults.standard.string(forKey: "userUUID")
        }
    }

}
