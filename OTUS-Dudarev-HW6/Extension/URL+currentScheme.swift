//
//  URL+currentScheme.swift
//  OTUS-Dudarev-HW6
//
//  Created by Ivan Dudarev on 06.02.2022.
//

import SwiftUI

extension URL {
    //Check scheme
    var isDeeplink: Bool {
        return scheme == "HW06" // HW06://<host>  
    }
    //Return active tab
    var tabIdentifier: TabIdentifier? {
        guard isDeeplink else { return nil }
        
        switch host {
            case "textInputTab":
                return .textTab // HW06://textInputTab/
            case "sufixTab":
                return .sufixTab // HW06://sufixTab/
            default: return nil
        }
    }
}


// Extensible tab id, equal to the URL schema
enum TabIdentifier {
    case textTab
    case sufixTab
    case historyTab
}
