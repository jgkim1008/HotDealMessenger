//
//  Service.swift
//  HotDealMessenger
//
//  Created by 김준건 on 2024/01/07.
//

import Foundation

protocol ServiceType {
    var authService: AuthentificationServiceType { get set }
    
}

class Services: ServiceType {
    var authService: AuthentificationServiceType
    
    init() {
        self.authService = AuthentificationService()
    }
}

class StubService: ServiceType {
    var authService: AuthentificationServiceType = StubAuthentificationService()
    
}
