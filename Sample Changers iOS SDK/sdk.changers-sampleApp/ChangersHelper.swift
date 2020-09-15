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
    var clientSecret: String { // client secret provided by Changers, they are different between each env
        switch self {
        case .development:
            return "client_secret"
        case .production:
            return "client_secret"
        case .stage:
            return "client_secret"
        }
    }
    
    var clientId: Int { // client id provided by Changers, they are different between each env
        switch self {
        case .development:
            return 0
        case .production:
            return 0
        case .stage:
            return 0
        }
    }
    
    var clientName: String {
        return  "client_name"
    }
}


struct ChangersHelper {
    
    static let changersEnv: ChangersEnv = ChangersEnv.production

    static var config: ChangersConfig {
        return ChangersConfig(clientId: changersEnv.clientId,
                              clientSecret: changersEnv.clientSecret,
                              clientName: changersEnv.clientName,
                              environment: changersEnv
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
