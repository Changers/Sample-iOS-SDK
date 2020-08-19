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
            return "CLIENT_SECRET_DEV"
        case .production:
            return "CLIENT_SECRET_PROD"
        case .stage:
            return "CLIENT_SECRET_STAGE"
        }
    }
    
    var clientId: Int { // client id provided by Changers, they are different between each env
        switch self {
        case .development:
            return 2
        case .production:
            return 2
        case .stage:
            return 2
        }
    }
    
    var clientName: String {
        return "CLIENT_NAME" // client named provided by Changers, they are different between each env
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
