//
//  DIContainer.swift
//  HotDealMessenger
//
//  Created by 김준건 on 2024/01/07.
//

import Foundation

class DIContainer: ObservableObject {
    var services: ServiceType
    
    init(services: ServiceType) {
        self.services = services
    }
}
