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
            return "w14mkOzaFvFKnWGc0vQmCyC6QJSXoeGV7bAPlDKD"
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
        return "darmstadt" // client named provided by Changers, they are different between each env
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
