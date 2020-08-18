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
     
    var clientSecret: String { // client secret provided by Changers
        switch self {
        case .development:
            return "dev_client_secret" 
        case .production:
            return "prod_client_secret"
        case .stage:
            return "stage_client_secret"
        }
    }
    
    var clientId: Int {
        return 2 // client id provided by Changers
    }
    
    var clientName: String {
        return "client_name" // client named provided by Changers
    }
}

struct ChangersHelper {
    
    static var config: ChangersConfig {
        let env = ChangersEnv.stage
        return ChangersConfig(clientId: env.clientId,
                              clientSecret: env.clientSecret,
                              clientName: env.clientName,
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
